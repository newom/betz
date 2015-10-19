module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.un, class: "gravatar")
	end

	def opponent(user, bet)
		bet.user1 == @user.un ? bet.user1 : bet.user2
	end
end