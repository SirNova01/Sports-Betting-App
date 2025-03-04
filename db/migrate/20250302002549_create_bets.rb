class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.decimal :amount
      t.float :odds
      t.decimal :potential_payout
      t.string :status

      t.timestamps
    end
  end
end
