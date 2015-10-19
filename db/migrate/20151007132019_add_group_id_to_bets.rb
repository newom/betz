class AddGroupIdToBets < ActiveRecord::Migration
  def change
    add_column :bets, :group_id, :integer
  end
end
