Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :github, '78624f7772aee525dd78', 'f96aeb2e8c73f6a0cea467e42445427047ad8795'
end 