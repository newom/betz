class RemoveAccpetedFromUsersForce < ActiveRecord::Migration
  def change
  	 remove_column :users, :accepted
  end
end
