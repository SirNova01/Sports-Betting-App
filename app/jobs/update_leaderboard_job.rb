# app/jobs/update_leaderboard_job.rb
class UpdateLeaderboardJob < ApplicationJob
  queue_as :leaderboard_updates

  def perform 

    top_users = User.leaderboard_top_winnings(10)

    data = top_users.map do |user|
      {
        user_id: user.id,
        email: user.email,
        total_payout: user.attributes["total_payout"]
      }
    end

    # Broadcast to Node.js via Redis
    $redis.publish('leaderboard_updates', data.to_json)
  end
end
