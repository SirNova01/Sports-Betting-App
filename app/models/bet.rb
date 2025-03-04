
class Bet < ApplicationRecord
  after_save :publish_leaderboard_update

  belongs_to :user
  belongs_to :game

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odds, presence: true, numericality: { greater_than: 0 }
  validates :potential_payout, presence: true, numericality: { greater_than: 0 }

  enum bet_type: { home: "home", away: "away", draw: "draw" }

  #  statuses: 'open', 'won', 'lost'

  validates :game_id, uniqueness: { scope: :user_id, message: 'You have already placed a bet on this game' }


  def publish_leaderboard_update
    # Broadcast to Node.js via Redis
    UpdateLeaderboardJob.perform_later
  end
end
