Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, 'r62cojgm913h', 'tys0ddHMPhmPWTW3', {:scope => 'r_fullprofile r_emailaddress r_network', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]}
  provider :eventbrite, ENV['PZFDCKP3ARMFISBEUW'], ENV['MNRJ5RQEINNFEDNIYWASLPYNDGOFM7KCJES5JC74S7Y46N3TNA']
end