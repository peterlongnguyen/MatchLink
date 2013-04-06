require 'eventbrite-client'
require 'json'
require 'uri'
require "net/http"

env_file = './environment.rb'
require env_file if File.file? env_file
EVENTBRITE_CLIENT_SECRET ||= '.'
EVENTBRITE_API_KEY ||= '.'

class EventbriteController < ApplicationController

  def get_data
  	access_code = extract_access_code_from_link()
    puts "ACCESS CODE: " + access_code

    @client_secret = 'MNRJ5RQEINNFEDNIYWASLPYNDGOFM7KCJES5JC74S7Y46N3TNA'
    @api_key = 'PZFDCKP3ARMFISBEUW'

    # once user allows access, exchange for access token
    access_token_JSON = exchange_code_for_token( access_code ) 
    access_token = parse_for_access_token( access_token_JSON )
    
    eventbrite_client = EventbriteClient.new({ access_token: access_token })

    # get array of event ids the logged in user is currently attending
    response = get_event_ids( eventbrite_client )
    event_ids = parse_event_ids( response.body )

  	event_ids.each do |event_id|
  		get_attendees(event_id)
  	end
    
    puts response.body

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
      "client_secret" => "MNRJ5RQEINNFEDNIYWASLPYNDGOFM7KCJES5JC74S7Y46N3TNA", 
      "client_id" => "PZFDCKP3ARMFISBEUW", 
      "grant_type" => "authorization_code"
    })
    
    response = http.request( request )
    response_body = response.body 
  end

  def get_event_ids( eventbrite_client )
  	return eventbrite_client.user_list_tickets()
  end

  # returns array of event id's user has bought tickets to
  def parse_event_ids( json )
  	arr = Array.new

  	parsed = JSON.parse( json )
  	orders = parsed["user_tickets"][1]["orders"]

  	orders.each do |item| 
      id = item["order"]["event"]["id"]
      arr.push(id)
    end

    return arr;
  end

  def get_attendees( event_id )
  	begin
    	attendees = @eb_client.event_list_attendees({ id: event_id })
    rescue StandardError
    	false
    else
      attendees	
    ensure
    	# do nothing
    end
  end

  def get_attendees_loop( event_ids )
  	event_ids.each do |event_id|
  		attendees = get_attendees( event_id )
    	puts attendees.body
  	end
  end

  def authenticate
  	redirect_to "https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=PZFDCKP3ARMFISBEUW&redirect_uri=http://localhost:3000/eventbrite_get_data"
  end

end
