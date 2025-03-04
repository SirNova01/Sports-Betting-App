class LeaderboardService
  def self.top_bettors(limit = 10)
    User.leaderboard_top_winnings(limit)
  end
end
