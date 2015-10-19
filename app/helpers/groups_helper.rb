module GroupsHelper

	def user_groups(user)
		SELECT id FROM user_groups WHERE user_id = user.id
	end
end