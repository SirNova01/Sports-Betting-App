class LeaderboardController < ApplicationController
  def index
    top_users = User.leaderboard_top_winnings(10) 
    render json: top_users.map { |u|
      {
        user_id: u.id,
        name: u.name,           
        total_payout: u.total_winnings.to_f
      }
    }
  end
end
 


class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  
  has_many :bets, dependent: :destroy

  
  def self.leaderboard_top_winnings(limit = 10)
    joins(:bets)
      .where(bets: { status: "won" })                   # only consider winning bets
      .select(
        "users.*, SUM(bets.potential_payout) AS total_winnings"
      )
      .group("users.id")
      .order("total_winnings DESC")
      .limit(limit)
  end
  
end
