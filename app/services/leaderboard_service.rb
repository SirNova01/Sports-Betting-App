class LeaderboardService
  def fetch_top_users(limit)
    Rails.cache.fetch(cache_key(limit), expires_in: 1.hour) do
      User.leaderboard_top_winnings(limit)
    end
  end

  def refresh_top_users(limit)
    top_users = User.leaderboard_top_winnings(limit)
    Rails.cache.write(cache_key(limit), top_users, expires_in: 1.hour)
    top_users
  end

  private

  def cache_key(limit)
    "leaderboard/top_users/#{limit}"
  end
end
