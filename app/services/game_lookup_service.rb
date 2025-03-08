class GameLookupService
  def initialize(id, external_id)
    @id = id
    @external_id = external_id
  end

  def call
    Game.find_by(id: @id) || Game.find_by(external_id: @external_id)
  end
end
