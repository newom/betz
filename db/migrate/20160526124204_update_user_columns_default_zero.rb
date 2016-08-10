class UpdateUserColumnsDefaultZero < ActiveRecord::Migration
  def change
  	change_column(:users, :wins, :int, :default => 0)
  	change_column(:users, :losses, :int, :default => 0)
  	change_column(:users, :money_won, :float, :default => 0)
  	change_column(:users, :money_lost, :float, :default => 0)
  	change_column(:users, :win_percentage, :float, :default => 0)
  end
end
