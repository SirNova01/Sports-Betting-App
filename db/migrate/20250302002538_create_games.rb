class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :home_team
      t.string :away_team
      t.string :score
      t.string :status
      t.integer :minute
      t.float :current_odds
      t.string :external_id

      t.timestamps
    end
  end
end
