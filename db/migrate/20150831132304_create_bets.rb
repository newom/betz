class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
    	t.string :user1
    	t.string :user2
    	t.string :prop
    	t.float :wager
    	t.string :category
    	t.string :winner
    	t.boolean :paid
    	t.timestamps :date
    end
  end
end
