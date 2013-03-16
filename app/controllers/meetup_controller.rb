require 'rMeetup'

class MeetupController < ApplicationController

  def get_meetup_data
    RMeetup::Client.api_key = "5517365648652e4145636b4153494d1b"

	results = RMeetup::Client.fetch(:events,{:zip => "90025"})
	results.each do |result|
		puts result
	end
	redirect_to root_url
  end

end