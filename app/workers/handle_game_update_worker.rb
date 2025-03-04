# This worker receives the raw JSON payload from Node.js and updates the DB.
class HandleGameUpdateWorker
  include Sidekiq::Worker

  def perform(payload)

    # Convert string keys to symbols, just for convenience
    data = payload.deep_symbolize_keys

    # e.g. "G123"
    external_id = data[:game_id]
    return if external_id.blank?



    # 1) Find or create the Game by external_id
    game = Game.find_or_create_by!(external_id: external_id) do |g|
      # Provide defaults if creating a new record
      g.home_team = data[:home_team]
      g.away_team = data[:away_team]
      g.score     = data[:score] || "0-0"
      g.status    = data[:status] || "scheduled"
      g.minute    = data[:minute] || 0
      g.current_odds    = data[:odds] || 1
    end


    # 2) Update relevant fields if game already exists
    game.update(
      home_team: data[:home_team],
      away_team: data[:away_team],
      score:     data[:score],
      status:    data[:status],
      minute:    data[:minute],
      current_odds: data[:odds]
      # any other fields as needed
    )

    # 3) Handle event logic, e.g., "goal", "yellow_card", etc.
    if data[:event].present?
      # we could store events in a separate table, or log them, etc.
      # UpdateOddsJob.perform_later(game.id) if data[:event] == "goal"
    end

  end
end
