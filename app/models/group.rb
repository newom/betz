class Group < ActiveRecord::Base
	def Group.group_display(group)
		users = UserGroup.where(:group_id => group).pluck(:user_id).to_a
		ranks = Group.rank(group)
		group_hash = Hash.new
		users.each do |user|
			total = Bet.where(:group_id => group, :user1 => user).where.not(:winner => nil).count + 
				Bet.where(:group_id => group, :user2 => user).where.not(:winner => nil).count
			wins = Bet.where(:group_id => group, :winner => user).count
			losses = total - wins
			rank = ranks.each_with_index.detect{|(key, value),index| key == user}.last + 1 #determine the user's rank
			record = "#{wins} - #{losses}"
			#calculate win percentage
			if total == 0
				win_percentage = 0
			elsif losses == 0
				win_percentage = 1.000
			else
				win_percentage = wins/(wins + losses).to_f
			end
			money_won = Bet.where(:group_id => group, :winner => user).pluck(:wager).sum
			money_lost = Bet.where(:group_id => group, :user1 => user).where.not(:winner => user).pluck(:wager).sum +
					Bet.where(:group_id => group, :user2 => user).where.not(:winner => user).pluck(:wager).sum
			arr = [user, record, win_percentage, money_won - money_lost]
			#sort user stats and info by rank
			group_hash.store(rank, arr)
		end
		return group_hash.sort_by{|key, value| key}.to_h
	end

	def Group.rank(group)
  		ranks = Hash.new
      	users = UserGroup.where(:group_id => group).pluck(:user_id).to_a
  		users.each do |user| #for each user, determine winning percentage
        	total = Bet.where("group_id = ? AND (user1 = ? OR user2 = ?) AND winner IS NOT NULL", group, user, user).count
        	if total == 0
          		win_percentage = 0
    		else 
          		win = Bet.where(:group_id => group, :winner => user).count
          		win_percentage = win / total.to_f
  			end
        	ranks.store(user, win_percentage)#assign user key win % value
      	end
      	sort = ranks.sort_by{|key, value| value}.reverse.to_h #sort users by value
      	#rank = sort.each_with_index.detect{|(key, value),index| key == user_id}.last + 1 #determine the user's rank
      	#group_hash.store(group.id, rank) #assign group key the rank value
  	return sort
	end
end
