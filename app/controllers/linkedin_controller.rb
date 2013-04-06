require 'linkedin'
require 'oauth'

class LinkedinController < ApplicationController

  def get_linkedin_data
    # Fill the keys and secrets you retrieved after registering your app
    api_key = 'r62cojgm913h'
    # user_token = '198b2c05-b22c-43b7-8533-08c28c4fbce6'
    # user_secret = 'f7d4875d-636a-45bd-bf1d-51d7d48c940b'

    user = User.find(current_user.id)
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
    consumer = OAuth::Consumer.new(api_key, api_secret, configuration)
     
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
    # Fill the keys and secrets you retrieved after registering your app
    api_key = 'r62cojgm913h'
    api_secret = 'tys0ddHMPhmPWTW3'
    
    user = User.find(current_user.id)
    user_token = current_user.linkedin_token
    user_secret = current_user.linkedin_secret
     
    # Specify LinkedIn API endpoint
    configuration = { 
      :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authenticate',
      :request_token_path =>'/uas/oauth/requestToken?scope=r_fullprofile+r_emailaddress+r_network+r_contactinfo', 
      :access_token_path => '/uas/oauth/accessToken'
    }
     
    consumer = OAuth::Consumer.new(api_key, api_secret, configuration)
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
        
    # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
    response = access_token.get("https://api.linkedin.com/uas/oauth/invalidateToken")
    profile = JSON.parse(response.body)
    puts "Profile data:"
    puts JSON.pretty_generate(profile)
    
    redirect_to root_url, :notice => 'Signed out!'
  end


end
