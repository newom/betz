class ChangeMobileToVarcharInUsers < ActiveRecord::Migration
  def self.up 
  	change_column :users, :mobile, :string
  end

  def self.down
  	change_column :users, :mobile, :int
  end
end
