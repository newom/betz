class ChangeMobileToBigInt < ActiveRecord::Migration
  def change
  	change_column :users, :mobile, :bigint
  end
end
