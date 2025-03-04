# # app/jobs/update_odds_job.rb
# class UpdateOddsJob < ApplicationJob
#   queue_as :odds_updates

#   def perform(game_id)
#     game = Game.find_by(id: game_id)
#     return unless game

#     # Example: do some logic to recalculate odds
#     new_odds = calculate_new_odds(game)

#     game.update(current_odds: new_odds)

#     # Publish to Redis channel that Node.js is subscribed to
#     $redis.publish('odds_updates', { game_id: game.id, new_odds: new_odds }.to_json)
#   end

#   private

#   def calculate_new_odds(game)
#     # Very naive example: random odds for demonstration
#     rand(1.5..3.0).round(2)
#   end
# end
