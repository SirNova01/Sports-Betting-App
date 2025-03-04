
class BetsController < ApplicationController

  # POST /bets
  def create
    # Example params: { bet: { game_id: 1, amount: 50.0, odds: 1.8 } }
    bet_params = params.require(:bet).permit(:game_id, :amount, :odds, :bet_type)

    game = Game.find(bet_params[:game_id])

    potential_payout = bet_params[:amount].to_f * bet_params[:odds].to_f
 
    bet = @current_user.bets.new(
      game: game,
      amount: bet_params[:amount],
      odds: bet_params[:odds],
      bet_type: bet_params[:bet_type],
      potential_payout: potential_payout,
      status: 'open'
    )

    if bet.save
      # Optionally, enqueue a job to update odds or notify Node.js
      # UpdateOddsJob.perform_later(game.id)
      render json: { bet: bet, message: 'Bet placed successfully.' }, status: :created
    else
      render json: { errors: bet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/:id/bets
  def user_bets
    user = User.find(params[:id])
    bets = user.bets.includes(:game)
    render json: bets, status: :ok
  end

  def bet_history
    bets = @current_user.bets.includes(:game)
    render json: bets, status: :ok
  end
    
end
