class UpdateBetOutcomeService
  def initialize(game)
    @game = game
  end

  def call
    return unless @game&.status == 'finished'

    @game.bets.where(status: 'open').each do |bet|
      if bet_won?(bet)
        bet.update(status: 'won')
      else
        bet.update(status: 'lost')
      end
    end
  end

  private

  def bet_won?(bet)
    home_score, away_score = @game.score.split('-').map(&:to_i)
    case bet.bet_type
    when "home"
      home_score > away_score
    when "away"
      away_score > home_score
    when "draw"
      home_score == away_score
    else
      false
    end
  end
end
