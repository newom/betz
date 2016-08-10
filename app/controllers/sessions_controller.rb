class SessionsController < ApplicationController
  def new
    @disable_nav = true
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to user
  	else
  		flash.now[:danger] = "Invalid email/password comination" #fix
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    @disable_nav = true
    redirect_to login_path
  end

end
