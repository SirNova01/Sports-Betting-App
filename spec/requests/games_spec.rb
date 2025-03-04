# require 'swagger_helper'

# RSpec.describe 'Games API', type: :request do
#   # Create a sample game record so that GET /games and GET /games/{id} can return data
#   let!(:game) do
#     Game.create!(
#       home_team: 'Team A',
#       away_team: 'Team B',
#       score: '1-0',                # can be nil if not applicable
#       status: 'ongoing',
#       minute: 15,
#       current_odds: { home: 1.5, draw: 2.5, away: 3.0 },
#       external_id: 'game-123'
#     )
#   end

#   # ------------------------------------------------------------------
#   # GET /games – List all games
#   # ------------------------------------------------------------------
#   path '/games' do
#     get('List all games') do
#       tags 'Games'
#       produces 'application/json'
      
#       response(200, 'successful') do
#         schema type: :array, items: {
#           type: :object,
#           properties: {
#             id:          { type: :integer },
#             home_team:   { type: :string },
#             away_team:   { type: :string },
#             score:       { type: :string, nullable: true },
#             status:      { type: :string },
#             minute:      { type: :integer, nullable: true },
#             current_odds:{ type: :object },
#             external_id: { type: :string },
#             created_at:  { type: :string, format: :datetime },
#             updated_at:  { type: :string, format: :datetime }
#           },
#           required: %w[id home_team away_team status external_id created_at updated_at]
#         }
        
#         run_test!
#       end
#     end
#   end

#   # ------------------------------------------------------------------
#   # GET /games/{id} – Show a game
#   # ------------------------------------------------------------------
#   path '/games/{id}' do
#     get('Show a game') do
#       tags 'Games'
#       produces 'application/json'
#       parameter name: :id, in: :path, type: :string, description: 'Game ID or External ID', required: true

#       response(200, 'successful') do
#         schema type: :object, properties: {
#           id:          { type: :integer },
#           home_team:   { type: :string },
#           away_team:   { type: :string },
#           score:       { type: :string, nullable: true },
#           status:      { type: :string },
#           minute:      { type: :integer, nullable: true },
#           odds:        { type: :object },  # Note: In the show action, current_odds is renamed to odds.
#           external_id: { type: :string },
#           created_at:  { type: :string, format: :datetime },
#           updated_at:  { type: :string, format: :datetime }
#         },
#         required: %w[id home_team away_team status external_id created_at updated_at]

#         # Use a valid game id (or external id) for the success case.
#         let(:id) { game.id }
#         run_test!
#       end

#       response(404, 'Game not found') do
#         # For the 404 case, use an id that won't be found.
#         let(:id) { 'non-existent' }
#         run_test!
#       end
#     end
#   end
# end


require 'swagger_helper'

RSpec.describe 'Games API', type: :request do
  # Create a sample game record so that GET /games and GET /games/{id} return data.
  let!(:game) do
    Game.create!(
      home_team: 'Team A',
      away_team: 'Team B',
      score: '1-0',
      status: 'ongoing',
      minute: 15,
      current_odds: { home: 1.5, draw: 2.5, away: 3.0 },
      external_id: 'game-123'
    )
  end

  # ------------------------------------------------------------------
  # GET /games – List all games
  # ------------------------------------------------------------------
  path '/games' do
    get('List all games') do
      security [BearerAuth: []]  # Indicate this endpoint requires authentication.
      tags 'Games'
      produces 'application/json'

      response(200, 'successful') do
        # Provide a valid token so that the request doesn't return 401.
        let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            home_team: { type: :string },
            away_team: { type: :string },
            score: { type: :string, nullable: true },
            status: { type: :string },
            minute: { type: :integer, nullable: true },
            current_odds: { type: :object },
            external_id: { type: :string },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          },
          required: %w[id home_team away_team status external_id created_at updated_at]
        }
        run_test!
      end
    end
  end

  # ------------------------------------------------------------------
  # GET /games/{id} – Show a game
  # ------------------------------------------------------------------
  path '/games/{id}' do
    get('Show a game') do
      security [BearerAuth: []]
      tags 'Games'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'Game ID or External ID', required: true

      response(200, 'successful') do
        let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
        schema type: :object, properties: {
          id: { type: :integer },
          home_team: { type: :string },
          away_team: { type: :string },
          score: { type: :string, nullable: true },
          status: { type: :string },
          minute: { type: :integer, nullable: true },
          odds: { type: :object },  # current_odds is renamed to odds in the show action.
          external_id: { type: :string },
          created_at: { type: :string, format: :datetime },
          updated_at: { type: :string, format: :datetime }
        },
        required: %w[id home_team away_team status external_id created_at updated_at]

        let(:id) { game.id }
        run_test!
      end

      response(404, 'Game not found') do
        let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
        let(:id) { 'non-existent' }
        run_test!
      end
    end
  end
end
