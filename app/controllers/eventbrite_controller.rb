require 'eventbrite-client'
require 'json'
require 'uri'
require 'net/http'

require 'util'

env_file = Rails.root().to_s + '/environment.rb'
require env_file if File.file? env_file
EVENTBRITE_CLIENT_SECRET ||= '.'
EVENTBRITE_CLIENT_ID ||= '.'

class EventbriteController < ApplicationController

  include Util

  @@eventbrite_client

  def get_eventbrite_client
    unless @@eventbrite_client.nil?
      return @@eventbrite_client
    else
      raise 'using uninitialized eventbrite_client'
    end
  end

  def set_eventbrite_client( eb_client )
    @@eventbrite_client = eb_client
  end

  def get_data
    # eventbrite embeds access code in the link it "returns"
  	access_code = extract_access_code_from_link()

    # once user allows access, exchange for access token
    access_token_JSON = exchange_code_for_token( access_code ) 
    access_token = parse_for_access_token( access_token_JSON )
    
    @@eventbrite_client = EventbriteClient.new({ access_token: access_token })

    # get array of event ids the logged in user is currently attending
    response = get_event_ids()
    event_ids = parse_for_event_ids( response.body )

    print_all_events_attendees( event_ids )
    
    redirect_to root_url
  end

  # extract access code returned in link parameters
  def extract_access_code_from_link
  	uri = URI("#{request.protocol}#{request.host_with_port}#{request.fullpath}")
  	access_code = uri.query.split('&')[0].split('=')[1]
  end

  def parse_for_access_token( json )
    parsed_JSON = JSON.parse( json )
    access_token = parsed_JSON["access_token"]
  end

  def exchange_code_for_token(access_code)
    uri = URI.parse("https://www.eventbrite.com/oauth/token")

    http = Net::HTTP.new( uri.host, uri.port )
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new( uri.request_uri )
    request.set_form_data({
      "code" => access_code, 
      "client_secret" => EVENTBRITE_CLIENT_SECRET,
      "client_id" => EVENTBRITE_CLIENT_ID,
      "grant_type" => "authorization_code"
    })
    
    response = http.request( request )
    response_body = response.body 
  end

  def get_event_ids
  	return @@eventbrite_client.user_list_tickets()
  end

  def get_event_details( event_id )
    return  @@eventbrite_client.event_get({ id: event_id }) 
  end

  # returns array of event id's user has bought tickets to
  def parse_for_event_ids( json )
  	id_list = Array.new

  	parsed = JSON.parse( json )
  	orders = parsed["user_tickets"][1]["orders"]

  	orders.each do |item| 
      id = item["order"]["event"]["id"]
      id_list.push(id)
    end

    return id_list;
  end

  def get_attendees( event_id )
  	begin
    	attendees = @@eventbrite_client.event_list_attendees({ id: event_id })
    rescue StandardError
    	false
    else
      attendees	
    ensure
    	# do nothing
    end
  end

  def print_all_events_attendees( event_ids )
  	event_ids.each do | event_id |
  		attendees = get_attendees( event_id )
      
      puts "event: " + get_event_details( event_id ).to_json()
      if is_of_type_bool( attendees ) 
        # puts "event_id: " + event_id.to_s() + " has hidden their attendees list!"
      else
        puts "attendees: " + attendees.to_json()
      end
  	end
  end

  def authenticate
  	redirect_to "https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=PZFDCKP3ARMFISBEUW&redirect_uri=http://localhost:3000/eventbrite_get_data"
  end

end
