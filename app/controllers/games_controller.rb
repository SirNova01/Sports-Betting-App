class GamesController < ApplicationController
  # GET /games
  def index
    games = Game.all
    render json: games, status: :ok
  rescue StandardError => e
    render json: { error: 'Something went wrong. Please try again.' }, status: :internal_server_error
  end

  # GET /games/:id
  def show
    service = GameLookupService.new(params[:id], params[:game_id])
    game = service.call

    if game
      render json: format_game(game), status: :ok
    else
      render json: { error: 'Game not found' }, status: :not_found
    end
  rescue StandardError => e
    render json: { error: 'Something went wrong. Please try again.' }, status: :internal_server_error
  end

  private

  def format_game(game)
    game.as_json.except('current_odds').merge('odds' => game.current_odds)
  end
end
