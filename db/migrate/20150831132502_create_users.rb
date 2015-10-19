class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :un
    	t.string :pw
    	t.string :email
    	t.string :mobile
    end
  end
end
