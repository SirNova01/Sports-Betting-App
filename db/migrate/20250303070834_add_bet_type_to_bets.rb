class AddBetTypeToBets < ActiveRecord::Migration[7.1]
  def change
    add_column :bets, :bet_type, :string
  end
end
