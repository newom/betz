class RemoveColumnsFromUserGroups < ActiveRecord::Migration
  def change
  		remove_column :user_groups, :created_at
  		remove_column :user_groups, :updated_at
  end
end
