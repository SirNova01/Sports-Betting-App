class LeaderboardController < ApplicationController
  def index
    top_users = LeaderboardService.new.fetch_top_users(10)
    render json: Leaderboard::LeaderboardPresenter.new(top_users).as_json
  rescue StandardError => e
    handle_error(e)
  end

  private

  def handle_error(error)
    render json: { error: error.message }, status: :internal_server_error
  end
end
