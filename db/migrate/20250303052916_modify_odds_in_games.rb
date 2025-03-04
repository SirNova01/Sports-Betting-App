class ModifyOddsInGames < ActiveRecord::Migration[7.1]
  def change
    change_column :games, :current_odds, :jsonb, using: 'to_json(current_odds)::jsonb'
  end
end