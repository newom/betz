class AddProposerToBets < ActiveRecord::Migration
  def change
    add_column :bets, :proposer, :int
  end
end
