class ChangeTimestampsInUserGroups < ActiveRecord::Migration
  def change
  	change_column(:user_groups, :created_at, :datetime, :null => true)
  	change_column(:user_groups, :updated_at, :datetime, :null => false)
  end
end
