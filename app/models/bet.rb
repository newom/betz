class Bet < ActiveRecord::Base

attr_accessible :user1, :user2, :prop, :wager, :category, :winner, :paid, :date;

end