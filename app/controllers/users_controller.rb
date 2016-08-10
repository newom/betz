class UsersController < ApplicationController

  def login
  end

  def new
    @disable_nav = true
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      log_in(@user)
      UserMailer.welcome_email(@user).deliver
      UserGroup.create(:user_id => @user.id, :group_id => 1)#need to change this
      @user.wins = 0
      @user.losses = 0
      flash[:success] = "WELCOME to the final table."
      redirect_to @user
  	else
  		flash[:danger] = "Form is invalid"
      render 'new'
  	end
  end

  def show
    @user = User.find(params[:id])
    @stats = User.overall_stats(@user)
    @winnings = @stats["money_won"] - @stats["money_lost"]
    @pending_bets = pending_bets(@user)
  end

  def open
    @user = User.find(params[:id])
    @user_groups = user_groups @user
    @open_bets = open_bets(@user).where(:winner == nil)
    @unpaid_bets = unpaid_bets(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #success
    else
      render 'edit'
    end
  end

  def pending
    @user = User.find(session[:user_id])
    @user_groups = user_groups @user
    @pending_bets = pending_bets(@user)
  end

  def groups
    @user = User.find(params[:id])
    @user_group_ids = UserGroup.where(:user_id => @user).pluck(:group_id).to_a
    @groups = Group.where("id in (?)", @user_group_ids)
    @ranks = Hash.new
    @groups.each do |group|
      rank = Group.rank(group)
      @ranks.store(group.id, rank.each_with_index.detect{|(key, value),index| key == @user.id}.last + 1)
    end
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
      @open_bets = Bet.where("(user1 = ? OR user1 = ? OR user2 = ? OR user2 = ?) AND winner IS NULL", user.un, user.id, user.un, user.id) 
      #winner = null OR paid = null", user.un, user.un) 
    end

    def unpaid_bets(user)
      bets = Bet.where("user1 = ? OR user1 = ? OR user2 = ? OR user2 = ? AND paid = ?", 
        user.un, user.id, user.un, user.id, false).where.not(winner: nil, winner: user.id)
    end

    def pending_bets(user)
      @user = user
      Bet.where("accepted = false && (user1 = ? OR user2 = ?)", @user.id, @user.id).find_each  
    end
end

