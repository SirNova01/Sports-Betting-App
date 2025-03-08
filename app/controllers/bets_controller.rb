class BetsController < ApplicationController
  before_action :set_user, only: [:user_bets]

  # POST /bets
  def create
    service = BetPlacementService.new(@current_user, bet_params)

    if (bet = service.call)
      render json: { bet: bet, message: 'Bet placed successfully.' }, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Something went wrong. Please try again.' }, status: :internal_server_error
  end

  # GET /users/:id/bets
  def user_bets
    bets = @user.bets.includes(:game)
    render json: bets, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # GET /bets/history
  def bet_history
    bets = @current_user.bets.includes(:game)
    render json: bets, status: :ok
  end

  private

  def bet_params
    params.require(:bet).permit(:game_id, :amount, :odds, :bet_type)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
