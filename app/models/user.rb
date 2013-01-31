class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :linkedin_id, type: String
  field :eventbrite_id, type: String

  attr_protected :provider, :uid, :name, :email, :linkedin_id, :eventbrite_id

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
  			puts 'name: ' + auth['info']['name']
  			user.email = auth['info']['email'] || ""
	    end
	end
  end

end

