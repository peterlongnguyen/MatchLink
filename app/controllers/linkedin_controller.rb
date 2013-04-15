require 'linkedin'
require 'oauth'

env_file = Rails.root().to_s + '/environment.rb'
require env_file if File.file? env_file
LINKEDIN_API_KEY ||= '.'
LINKEDIN_SECRET_KEY ||= '.'

class LinkedinController < ApplicationController

  def get_linkedin_data
    #user = User.find( current_user.id )
    user_token = current_user.linkedin_token
    user_secret = current_user.linkedin_secret

    puts "user token: " 
    puts current_user.linkedin_token

    puts "user secret: " 
    puts current_user.linkedin_secret
     
    # Specify LinkedIn API endpoint
    configuration = { 
      :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authenticate',
      :request_token_path =>'/uas/oauth/requestToken?scope=r_fullprofile+r_emailaddress+r_network+r_contactinfo', 
      :access_token_path => '/uas/oauth/accessToken'
    }
     
    # Use your API key and secret to instantiate consumer object
    consumer = OAuth::Consumer.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY, configuration)
     
    # Use your developer token and secret to instantiate access token object
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
    
    fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections', 'languages', 'educations'].join(',')
    
    # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
    response = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json')
    profile = JSON.parse(response.body)
    puts "Profile data:"
    puts JSON.pretty_generate(profile)
    
    redirect_to root_url
  end

  def logout  
    #user = User.find(current_user.id)
    user_token = current_user.linkedin_token
    user_secret = current_user.linkedin_secret
     
    # Specify LinkedIn API endpoint
    configuration = { 
      :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authenticate',
      :request_token_path =>'/uas/oauth/requestToken?scope=r_fullprofile+r_emailaddress+r_network+r_contactinfo', 
      :access_token_path => '/uas/oauth/accessToken'
    }
     
    consumer = OAuth::Consumer.new(LINKEDIN_API_KEY, LINKEDIN_SECRET_KEY, configuration)
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
        
    # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
    response = access_token.get("https://api.linkedin.com/uas/oauth/invalidateToken")
    profile = JSON.parse(response.body)
    puts "Profile data:"
    puts JSON.pretty_generate(profile)
    
    redirect_to root_url, :notice => 'Signed out!'
  end


end
