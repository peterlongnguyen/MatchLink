require 'eventbrite-client'
require 'json'
require 'uri'


class EventbriteController < ApplicationController

  def get_data

  	uri = URI("#{request.protocol}#{request.host_with_port}#{request.fullpath}")
  	access_code = uri.query.split('&')[0].split('=')[1]
  	puts "ACCESS CODE: " + access_code

    eb_auth_tokens = {
      app_key: 'PZFDCKP3ARMFISBEUW',
      user_key: '131424491619036258963'
    }
    
    #@eb_client = EventbriteClient.new(eb_auth_tokens)

    @eb_client = EventbriteClient.new({ access_token: access_code })

    response = get_event_ids()

    # get array of event ids the logged in user is currently attending
    event_ids = parse_event_ids(response.body)

  	event_ids.each do |event_id|
  		get_attendees(event_id)
  	end
    
    puts response.body

    redirect_to root_url
  end

  def get_event_ids
  	return @eb_client.user_list_tickets()
  end

  # returns array of event id's user has bought tickets to
  def parse_event_ids(json)
  	arr = Array.new

  	parsed = JSON.parse(json)
  	orders = parsed["user_tickets"][1]["orders"]

  	orders.each do |item| 
	  id = item["order"]["event"]["id"]
	  arr.push(id)
	end

	return arr;
  end

  def get_attendees(event_id)
  	begin
    	attendees = @eb_client.event_list_attendees({ id: event_id })
    rescue StandardError
    	false
    else
    	attendees_parsed = JSON.parse(attendees.body)
    	puts attendees.body
    ensure
    	# do nothing
    end
  end

  def authenticate
  	redirect_to "https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=PZFDCKP3ARMFISBEUW&redirect_uri=http://localhost:3000/eventbrite_get_data"
  end

end