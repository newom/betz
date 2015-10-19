class AddDate < ActiveRecord::Migration
  def change
  	add_column :bets, :date, :string
  end
end
