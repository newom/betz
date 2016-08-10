class AddAcceptedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepted, :bool
  end
end
