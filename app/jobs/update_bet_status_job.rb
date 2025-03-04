
class UpdateBetStatusJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.find_by(id: game_id)
    return unless game && game.status == 'finished'

    # Find all bets for this game that are still pending
    game.bets.where(status: 'open').each do |bet|
      if bet_won?(bet, game)
        bet.update(status: 'won') 
        update_user_balance(bet.user, bet.potential_payout)
        UpdateLeaderboardJob.perform_later
      else
        bet.update(status: 'lost')
      end
    end
  end

  private


  def bet_won?(bet, game)
    # Extract the home and away scores from the game's score string (e.g., "2-1")
    home_score, away_score = game.score.split('-').map(&:to_i)
  
    case bet.bet_type
    when "home"
      return true if home_score > away_score # Home team wins
    when "away"
      return true if away_score > home_score # Away team wins
    when "draw"
      return true if home_score == away_score # It's a draw
    end
  
    false
  end

  # If user wins, update their balance
  def update_user_balance(user, winnings)
    # user.increment!(:balance, winnings)
  end
end
