# app/presenters/leaderboard/leaderboard_presenter.rb
module Leaderboard
  class LeaderboardPresenter
    def initialize(users)
      @users = users
    end

    def as_json
      @users.map do |user|
        {
          user_id:      user.id,
          name:         user.name,
          total_payout: user.total_winnings.to_f
        }
      end
    end
  end
end
