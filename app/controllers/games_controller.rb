class GamesController < ApplicationController
  # GET /games
  def index
    games = Game.all
    render json: games, status: :ok
  end

  # GET /games/:id
  def show
    game = Game.find_by(id: params[:id]) || Game.find_by(external_id: params[:id])

    if game
      formatted_game = game.as_json.except('current_odds') # Remove 'current_odds'
      formatted_game['odds'] = game.current_odds # Rename 'current_odds' to 'odds'

      render json: formatted_game, status: :ok
    else
      render json: { error: 'Game not found' }, status: :not_found
    end
  end

end
