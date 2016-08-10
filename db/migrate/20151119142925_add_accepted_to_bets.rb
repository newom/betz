class AddAcceptedToBets < ActiveRecord::Migration
  def change
    add_column :bets, :accepted, :bool
  end
end
