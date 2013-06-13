module UsersHelper

	def gravatar_for(user, properties={}) 
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase) 
		gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png"
		properties[:alt] ||= user.name
		properties[:class] ||= 'gravatar'
		image_tag(gravatar_url, properties)
	end
end
