class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
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
