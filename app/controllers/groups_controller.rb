class GroupsController < ApplicationController
	def show
		@group = Group.find(params[:id])
		@stats = Group.group_display(@group)
	end
end
