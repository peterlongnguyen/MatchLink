require 'linkedin'

class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :linkedin_id, type: String
  field :eventbrite_id, type: String
  field :linkedin_token, type: String
  field :linkedin_secret, type: String
  field :eventbrite_access_token, type: String

  attr_protected :provider, :uid, :name, :email, :linkedin_id, :eventbrite_id, :linkedin_secret, :linkedin_token, :eventbrite_access_token

  validates :provider, :presence => true
  validates :uid, :presence => true
  validates :name, :presence => true
  validates :email, :presence => true

  def self.create_with_omniauth(auth)
  	create! do |user|
  		user.provider = auth['provider']
  		user.uid = auth['uid']
  		if auth['info']
  			user.name = auth['info']['name'] || ""
  			user.email = auth['info']['email'] || ""
        # user.linkedin_id = auth['profile']['id'] || ""
	    end
      user.linkedin_token = auth['credentials']['token']
      user.linkedin_secret = auth['credentials']['secret']
    end
  end

end

