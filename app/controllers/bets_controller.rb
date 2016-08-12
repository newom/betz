class BetsController < ApplicationController

  def index
  	user_id = session[:user_id]
	  @current_user ||= User.find_by(id: user_id)
  	@user = @current_user.un
  end

  def new
  	@user = session[:user_id]
    @bet = Bet.new
    @user_group_ids = UserGroup.select(:group_id).where("user_id = ?", session[:user_id])
    @group_ids = UserGroup.where("group_id in (?) AND user_id != ?", @user_group_ids, session[:user_id]).pluck(:user_id).to_a
    @opponents = User.find(@group_ids)
  end

  def show
  	@bet = Bet.find(params[:id])
    @group = @bet.group.name
    @user1 = User.find_by(id: @bet.user1)
    @user2 = User.find_by(id: @bet.user2)
    @users = [@user1, @user2]
    
    if @bet.winner != nil
      @winner = User.find(@bet.winner).un
      #delete this comment
    end  
    
    if @bet.accepted == FALSE
      @show_accept = TRUE
    end
  end

  def create
    @bet = Bet.new(:user1 =>  session[:user_id], :user2 => params[:@bet][:opponent], :prop => params[:@bet][:prop], 
                      :wager => params[:@bet][:wager], :category => params[:@bet][:category], :paid => FALSE, :accepted => FALSE)
    if @bet.save
      @bet.update_attribute(:accepted, FALSE) #why won't it update in bet?
      @bet.update_attribute(:group_id, 1) 
      @user_id = session[:user_id]
      @sender = User.find_by(id: @user_id)
      @receiver = User.find_by(id: @bet.user2)
      UserMailer.new_bet_email(@sender, @receiver).deliver
      flash[:success] = "Proposition sent."
      redirect_to user_url(@user_id)
    else
      @user_group_ids = UserGroup.select(:id).where("user_id = ?", session[:user_id])
      @group_users = UserGroup.select(:user_id).where("group_id in (?) AND user_id != ?", @user_group_ids, session[:user_id])
      @opponents = User.where("id in (?)", @group_users)
      render 'new'
    end
  end

  def accept
    @bet = Bet.find(params[:@id])
    if params[:commit] == "Accept"
      @bet.update_attribute(:accepted, TRUE)
      flash[:success] = "Bet Accepted. Well Done."
      UserMailer.bet_accepted_email(@bet.user1, @bet.user2, @bet).deliver
      redirect_to pending_user_path(:user_id)
    elsif params[:commit] == "Counter"
      @opponent = @bet.user1
      render 'counter'
    elsif params[:commit] == "Reject"
      @bet.destroy
      flash[:warning] = "No deal McCuthen, that moon money's mine!"
      UserMailer.bet_rejected_email(@bet.user1, @bet.user2, @bet).deliver
      redirect_to pending_user_path(session[:user_id])
    end 
  end

  def update
    @bet = Bet.find(params[:id])
    #update for ???
    if params[:commit] == "Update"
      @bet.update_attribute(:accepted, TRUE)
      flash[:success] = "Bet has been updated."
      UserMailer.bet_accepted_email(@bet.user1, @bet.user2, @bet).deliver
      redirect_to user_url(session[:user_id])
    end

    #update winner
    if params[:commit] == "Save Winner"
      @bet.update_attribute(:winner, params[:winner])
      #update wins/losses, win percentage, and cash
      user1 = User.find(@bet.user1)
      user2 = User.find(@bet.user2)
      if params[:winner].to_i == user1[:id]
        User.update(user1, :wins => user1.wins + 1, :money_won => user1.money_won + params[:@wager].to_f)
        User.update(user2, :losses => user2.losses + 1, :money_lost => user2.money_lost + params[:@wager].to_f)
        #maybe delete, currently buggy, can just calculate win percentage on the fly
        User.update(user1, :win_percentage => user1.wins/(1 + user1.wins + user1.losses).to_f)
        User.update(user2, :win_percentage => user2.wins/(1 + user2.wins + user2.losses).to_f)
      else
        User.update(user2, :wins => user2.wins + 1, :money_won => user2.money_won + params[:@wager].to_f)
        User.update(user1, :losses => user1.losses + 1, :money_lost => user1.money_lost + params[:@wager].to_f)
        #maybe delete, currenyly buggy
        User.update(user2, :win_percentage => user2.wins/(1 + user2.wins + user2.losses).to_f)
        User.update(user1, :win_percentage => user1.wins/(1 + user1.wins + user1.losses).to_f)
      end
      flash[:success] = "Winner updated."
      #Send Bet has been updated e-mail
      redirect_to open_user_path(session[:user_id])
    end

    #update for a counter
    if params[:commit] == "Counter"  
      if @bet.update_attributes(:prop => params[:counter][:prop], :wager => params[:counter][:wager].delete("$,"), :category => 
        params[:counter][:category], :proposer => session[:user_id])
        flash[:success] = "Counter offer sent."
        #Send Bet has been updated e-mail
        redirect_to pending_user_path(session[:user_id])
      else
        render 'counter'
      end
    end
  end

  def pay
    @bet = Bet.find(params[:id])
    if @bet.winner == @bet.user1 
      @receiver = User.find(@bet.user1).email
    else
      @receiver = User.find(@bet.user2).email
    end
    @response = Bet.pay(@receiver, @bet.wager, @bet.id)
    redirect_to "https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=#{@response[:payKey]}"
  end

  def paid
    @bet = Bet.find(params[:id])
    @bet.update_attributes(:paid => TRUE)
    flash[:success] = "#{@bet.prop} paid in full. You are the anti-Pitts."
    redirect_to open_user_path(session[:user_id])
  end
end
