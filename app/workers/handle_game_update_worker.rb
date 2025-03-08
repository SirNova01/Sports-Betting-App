class HandleGameUpdateWorker
  include Sidekiq::Worker

  def perform(payload)

    data = payload.deep_symbolize_keys
    external_id = data[:game_id]
    return if external_id.blank?

    game = Game.find_or_create_by!(external_id: external_id) do |g|
      g.home_team = data[:home_team]
      g.away_team = data[:away_team]
      g.score     = data[:score] || "0-0"
      g.status    = data[:status] || "scheduled"
      g.minute    = data[:minute] || 0
      g.current_odds    = data[:odds] || 1
    end

    game.update(
      home_team: data[:home_team],
      away_team: data[:away_team],
      score:     data[:score],
      status:    data[:status],
      minute:    data[:minute],
      current_odds: data[:odds]
    )

  end
end
