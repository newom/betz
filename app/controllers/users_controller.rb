class UsersController < ApplicationController

  def login
  end

  def new
    #@user = User.new(user_params)
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "WELCOME to the final table."
      redirect_to @user
  	else
  		flash[:danger] = "Form is invalid"
      render 'new'
  	end
 end

  def show
    @user = User.find(params[:id])
    @user_groups = user_groups @user
    @open_bets = open_bets @user
  end

 private
  def user_params
    params.require(:user).permit(:un, :email, :password, :password_confirmation, :mobile)
  end

  def user_groups(user)
   @user_groups = UserGroup.where(user_id = user.id).find_each
  end

  #find open bets
  def open_bets(user)
    @open_bets = Bet.where("user1 = ? OR user2 = ? && winner = null or paid = null", user.un, user.un) 
  end

end

