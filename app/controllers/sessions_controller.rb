class SessionsController < ApplicationController
	def create
	  auth = request.env['omniauth.auth']
	  user = User.where(:provider => auth['provider'],
	                    :uid => auth['uid']).first || User.create_with_omniauth(auth)

	  user.linkedin_token = auth['credentials']['token']
      user.linkedin_secret = auth['credentials']['secret']

	  session[:user_id] = user.id
	  redirect_to root_url, :notice => "Signed in!"
	end

	def new
	  redirect_to '/auth/linkedin'
	end

	def failure
	  redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end

	def destroy
	  # # Fill the keys and secrets you retrieved after registering your app
	  #   api_key = 'r62cojgm913h'
	  #   api_secret = 'tys0ddHMPhmPWTW3'
	    
	  #   user = User.find(current_user.id)
	  #   user_token = current_user.linkedin_token
	  #   user_secret = current_user.linkedin_secret
	     
	  #   # Specify LinkedIn API endpoint
	  #   configuration = { 
	  #     :site => 'https://api.linkedin.com/uas/oauth/invalidateToken'
	  #   }
	     
	  #   consumer = OAuth::Consumer.new(api_key, api_secret, configuration)
	  #   access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
	        
	  #   # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
	  #   response = access_token.get("https://api.linkedin.com/uas/oauth/invalidateToken")
	  #   puts "Profile data:"
	  #   puts response

	  #   user.linkedin_token = nil
   #    	user.linkedin_secret = nil
      	
      	reset_session

	  redirect_to root_url, :notice => 'Signed out!'
	end
end
