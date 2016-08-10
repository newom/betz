class RemoveAccpetedFromUsers < ActiveRecord::Migration
 
  remove_column :users, :accepted
  
end
