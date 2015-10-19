class RemovePasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pw, :string
  end
end
