module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.un, class: "gravatar")
	end

	def opponent(user, bet)
		#bet.user1.downcase == user.downcase ? bet.user2 : bet.user1
    bet.user1 == params[:id] ? User.find(bet.user2).un : User.find(bet.user1).un
	end

	def paid?(bet)
		bet.paid == FALSE ? FALSE : TRUE
	end

	def winner?(bet)
		bet.winner == nil ? FALSE : TRUE
	end

  def winner(user_id)
    User.find(user_id).un
  end

	def group_name(bet)
		user_group = UserGroup.find(bet.group_id)
		group_name = Group.find(user_group).name
	end

	def user_bets
		Bet.where("user1 = ? OR user1 = ? OR user2 = ? OR user2 = ?", user.un, user.id, user.un, user.id) 
	end

	def pending_bets(user)
		Bet.where("user1 = ? OR user1 = ? OR user2 = ? OR user2 = ? AND accepted = ?", user.un, user.id, user.un, user.id, FALSE) 
	end

	def rank
    @rank = @ranks[1] #ruby hash function to return value by key
  end
  
  def record(group, user_id)
    	total = Bet.where("group_id = ? AND (user1 = ? OR user2 = ?) AND winner IS NOT NULL", group, user_id, user_id).count
    	win = Bet.where(:group_id => group, :winner => params[:id]).count
    	loss = total - win
    	"#{win}-#{loss}"
  end

  def name(user)
    User.find(user).un
  end


  	# def rank(user, group)
  	# 	ranks = Hash.new
   #    users = UserGroup.where(:group_id => group).pluck(:user_id).to_a
  	# 	user_id = user.id
  	# 	users.each do |user|
  	# 		total = Bet.where("group_id = ? AND (user1 = ? OR user2 = ?) AND winner IS NOT NULL", group, user, user).count
   #      if total == 0
   #        win_percentage = 0
   #  		else 
   #        win = Bet.where(:group_id => group, :winner => user).count
  	# 	    win_percentage = win / total.to_f
  	# 	  end
   #      ranks.store(user, win_percentage)#consider using win% function
   #    end
  	# 	sort = ranks.sort_by{|key, value| value}.reverse.to_h
  	# 	return sort.each_with_index.detect{|(key, value),index| key == user_id}.last + 1
  	# end

    def win_percentage(user_id)
      user = User.find(user_id)
      user.wins/(user.wins + user.losses).to_f
    end	

    def win_percentage_group(user, group)
  	  user_id = user.id
  	  total = Bet.where("group_id = ? AND (user1 = ? OR user2 = ?) AND winner IS NOT NULL", group, user_id, user_id).count
    	win = Bet.where(:group_id => group, :winner => user).count
  		wp = win / total.to_f	
  	end

  	def winnings (user, group)
  		user_id = user.id
  		win = Bet.where(:group_id => group, :winner => user).pluck(:wager).inject(:+)
  		if win == nil
  			win = 0
  		end
  		loss = Bet.where("(user1 = ? OR user2 = ?) AND group_id = ? AND winner != ? AND winner IS NOT NULL", user, user, group, user).pluck(:wager).inject(:+)
  		if loss == nil
  			loss = 0
  		end
  		return win - loss
  	end
end