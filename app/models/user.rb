class User < ActiveRecord::Base

	has_secure_password

	attr_accessor :remember_token

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	validates :un, :presence => true, :uniqueness => true, :length => {:in => 3..20}

	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

	validates :password, :confirmation => true

	validates_length_of :password, :in => 6..20

	#Returns hash digest of string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		#return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def User.ranks(user, groups) #returns user's rank in each group
  	group_hash = Hash.new
  	ranks = Hash.new
    user_id = user.id
    groups.each do |group| #for each group, select every user
      users = UserGroup.where(:group_id => group).pluck(:user_id).to_a
  		users.each do |user| #for each user, determine total bets and winning percentage
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
      	rank = sort.each_with_index.detect{|(key, value),index| key == user_id}.last + 1 #determine the user's rank
      	group_hash.store(group.id, rank) #assign group key the rank value
    end
  	return group_hash
  end

  def User.overall_stats(user)
  	stats_hash = Hash.new
    user_id = user.id
  	stats_hash["win"] = user.wins
  	stats_hash["loss"] = user.losses
  	stats_hash["win_percentage"] = user.win_percentage
  	stats_hash["money_won"] = user.money_won
  	stats_hash["money_lost"] = user.money_lost
    #compute user ranks
    users = User.all
    ranks = Hash.new
    users.each do |user|
      ranks.store(user.id, user.win_percentage)
    end
    sort = ranks.sort_by{|key, value| value}.reverse.to_h
    stats_hash["rank"] = sort.each_with_index.detect{|(key, value),index| key == user_id}.last + 1
    return stats_hash
  end
end