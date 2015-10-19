class BetsController < ApplicationController

  def index
  	user_id = session[:user_id]
	@current_user ||= User.find_by(id: user_id)
  	@user = @current_user.un
  end

end