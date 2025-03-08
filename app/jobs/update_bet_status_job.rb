
class UpdateBetStatusJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.find_by(id: game_id)
    return unless game && game.status == 'finished'

    UpdateBetOutcomeService.new(game).call
    
    LeaderboardService.new.refresh_top_users(10)
  end

end
