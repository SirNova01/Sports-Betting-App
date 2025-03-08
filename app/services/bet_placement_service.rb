class BetPlacementService
  attr_reader :errors

  def initialize(user, params)
    @user = user
    @params = params
    @errors = []
  end

  def call
    game = Game.find_by(external_id: @params[:game_id])

    unless game
      @errors << 'Game not found'
      return nil
    end

    bet = @user.bets.new(
      game: game,
      amount: @params[:amount],
      odds: @params[:odds],
      bet_type: @params[:bet_type],
      potential_payout: calculate_payout,
      status: 'open'
    )

    if bet.save
      bet
    else
      @errors = bet.errors.full_messages
      nil
    end
  end

  private

  def calculate_payout
    @params[:amount].to_f * @params[:odds].to_f
  end
end
