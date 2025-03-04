# require 'swagger_helper'

# RSpec.describe 'Bets API', type: :request do
#   # Create a sample Game record so that Game.find(game_id) doesn't fail
#   let!(:game) do
#     Game.create!(
#       home_team: 'Team A',
#       away_team: 'Team B',
#       score: nil,
#       status: 'scheduled',
#       minute: 0,
#       current_odds: {}
#     )
#   end

#   # ------------------------------------------------------------------
#   #  POST /bets – Create a Bet
#   # ------------------------------------------------------------------
#   path '/bets' do
#     post('Create a bet') do
#       security [BearerAuth: []]
#       tags 'Bets'
#       consumes 'application/json'
#       produces 'application/json'

#       parameter name: :bet, in: :body, schema: {
#         type: :object,
#         properties: {
#           game_id: { type: :integer },
#           amount: { type: :number },
#           odds: { type: :number },
#           bet_type: { type: :string, nullable: true }
#         },
#         required: %w[game_id amount odds]
#       }

#       response(201, 'Bet created') do
#         let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
#         let(:bet) do
#           {
#             game_id: game.id,
#             amount: 50.0,
#             odds: 1.8,
#             bet_type: 'home'
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end

#       response(401, 'Unauthorized') do
#         # Simulate a missing token by setting Authorization to nil
#         let(:'Authorization') { nil }
#         let(:bet) do
#           {
#             game_id: game.id,
#             amount: 50.0,
#             odds: 1.8,
#             bet_type: 'home'
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end

#       response(422, 'Unprocessable Entity') do
#         let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
#         let(:bet) do
#           {
#             game_id: nil,
#             amount: nil,
#             odds: nil
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end

#   # ------------------------------------------------------------------
#   #  GET /bets – List all bets
#   # ------------------------------------------------------------------
#   path '/bets' do
#     get('List all bets') do
#       tags 'Bets'
#       produces 'application/json'

#       response(200, 'successful') do
#         schema type: :array, items: {
#           type: :object,
#           properties: {
#             id: { type: :integer },
#             game_id: { type: :integer },
#             user_id: { type: :integer },
#             amount: { type: :number },
#             odds: { type: :number },
#             bet_type: { type: :string, nullable: true },
#             potential_payout: { type: :number },
#             status: { type: :string },
#             created_at: { type: :string, format: :datetime },
#             updated_at: { type: :string, format: :datetime }
#           },
#           required: %w[id game_id user_id amount odds status created_at updated_at]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end

#   # ------------------------------------------------------------------
#   #  GET /betshistory – Retrieve bet history
#   # ------------------------------------------------------------------
#   path '/betshistory' do
#     get('Retrieve bet history') do
#       tags 'Bets'
#       produces 'application/json'

#       response(200, 'successful') do
#         # Typically returns an array of bets, possibly with nested game info
#         schema type: :array, items: {
#           type: :object,
#           properties: {
#             id: { type: :integer },
#             user_id: { type: :integer },
#             game_id: { type: :integer },
#             amount: { type: :number },
#             odds: { type: :number },
#             bet_type: { type: :string, nullable: true },
#             potential_payout: { type: :number },
#             status: { type: :string },
#             created_at: { type: :string, format: :datetime },
#             updated_at: { type: :string, format: :datetime },
#             game: {
#               type: :object,
#               properties: {
#                 id: { type: :integer },
#                 home_team: { type: :string },
#                 away_team: { type: :string },
#                 score: { type: :string, nullable: true },
#                 status: { type: :string, nullable: true },
#                 minute: { type: :integer, nullable: true }
#               }
#             }
#           },
#           required: %w[id user_id game_id amount odds status created_at updated_at]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end
# end




# require 'swagger_helper'

# RSpec.describe 'Bets API', type: :request do
#   # Create a sample Game record so that Game.find(game_id) doesn't fail
#   let!(:game) do
#     Game.create!(
#       home_team: 'Team A',
#       away_team: 'Team B',
#       score: nil,
#       status: 'scheduled',
#       minute: 0,
#       current_odds: {}
#     )
#   end

#   # ------------------------------------------------------------------
#   #  POST /bets – Create a Bet
#   # ------------------------------------------------------------------
#   path '/bets' do
#     post('Create a bet') do
#       security [BearerAuth: []]
#       tags 'Bets'
#       consumes 'application/json'
#       produces 'application/json'

#       parameter name: :bet, in: :body, schema: {
#         type: :object,
#         properties: {
#           game_id: { type: :integer },
#           amount: { type: :number },
#           odds: { type: :number },
#           bet_type: { type: :string, nullable: true }
#         },
#         required: %w[game_id amount odds]
#       }

#       response(201, 'Bet created') do
#         let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
#         let(:bet) do
#           {
#             game_id: game.id,
#             amount: 50.0,
#             odds: 1.8,
#             bet_type: 'home'
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end

#       response(401, 'Unauthorized') do
#         # Simulate missing token by setting Authorization to nil
#         let(:'Authorization') { nil }
#         let(:bet) do
#           {
#             game_id: game.id,
#             amount: 50.0,
#             odds: 1.8,
#             bet_type: 'home'
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end

#       response(422, 'Unprocessable Entity') do
#         let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
#         let(:bet) do
#           {
#             game_id: game.id,   # Use a valid game_id so Game.find doesn't throw an error
#             amount: nil,        # Invalid value to trigger validations
#             odds: nil           # Invalid value to trigger validations
#           }
#         end

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end

#   # ------------------------------------------------------------------
#   #  GET /bets – List all bets
#   # ------------------------------------------------------------------
#   path '/bets' do
#     get('List all bets') do
#       tags 'Bets'
#       produces 'application/json'

#       response(200, 'successful') do
#         schema type: :array, items: {
#           type: :object,
#           properties: {
#             id: { type: :integer },
#             game_id: { type: :integer },
#             user_id: { type: :integer },
#             amount: { type: :number },
#             odds: { type: :number },
#             bet_type: { type: :string, nullable: true },
#             potential_payout: { type: :number },
#             status: { type: :string },
#             created_at: { type: :string, format: :datetime },
#             updated_at: { type: :string, format: :datetime }
#           },
#           required: %w[id game_id user_id amount odds status created_at updated_at]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end

#   # ------------------------------------------------------------------
#   #  GET /betshistory – Retrieve bet history
#   # ------------------------------------------------------------------
#   path '/betshistory' do
#     get('Retrieve bet history') do
#       tags 'Bets'
#       produces 'application/json'

#       response(200, 'successful') do
#         # Typically returns an array of bets, possibly with nested game info
#         schema type: :array, items: {
#           type: :object,
#           properties: {
#             id: { type: :integer },
#             user_id: { type: :integer },
#             game_id: { type: :integer },
#             amount: { type: :number },
#             odds: { type: :number },
#             bet_type: { type: :string, nullable: true },
#             potential_payout: { type: :number },
#             status: { type: :string },
#             created_at: { type: :string, format: :datetime },
#             updated_at: { type: :string, format: :datetime },
#             game: {
#               type: :object,
#               properties: {
#                 id: { type: :integer },
#                 home_team: { type: :string },
#                 away_team: { type: :string },
#                 score: { type: :string, nullable: true },
#                 status: { type: :string, nullable: true },
#                 minute: { type: :integer, nullable: true }
#               }
#             }
#           },
#           required: %w[id user_id game_id amount odds status created_at updated_at]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end

#         run_test!
#       end
#     end
#   end
# end



require 'swagger_helper'

RSpec.describe 'Bets API', type: :request do
  # Create a sample Game record so that Game.find(game_id) doesn't fail
  let!(:game) do
    Game.create!(
      home_team: 'Team A',
      away_team: 'Team B',
      score: nil,
      status: 'scheduled',
      minute: 0,
      current_odds: {}
    )
  end

  # Register a user and get a token for endpoints that require authentication.
  let!(:token) { register_user_and_get_token }
  # Create a user for the GET /users/:id/bets endpoint.
  let!(:user) do
    params = { name: 'Test User', email: 'test@example.com', password: 'password' }
    result = UserRegistrationService.new(params).call
    result[:user]
  end
  let(:user_id) { user.id }

  # ------------------------------------------------------------------
  #  POST /bets – Create a Bet
  # ------------------------------------------------------------------
  path '/bets' do
    post('Create a bet') do
      security [BearerAuth: []]
      tags 'Bets'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :bet, in: :body, schema: {
        type: :object,
        properties: {
          game_id: { type: :integer },
          amount: { type: :number },
          odds: { type: :number },
          bet_type: { type: :string, nullable: true }
        },
        required: %w[game_id amount odds]
      }

      response(201, 'Bet created') do
        let(:'Authorization') { "Bearer #{token}" }
        let(:bet) do
          {
            game_id: game.id,
            amount: 50.0,
            odds: 1.8,
            bet_type: 'home'
          }
        end

        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:'Authorization') { "Bearer #{token}" }
        let(:bet) do
          {
            game_id: game.id,  # valid game ID so lookup works
            amount: nil,       # invalid to trigger validations
            odds: nil          # invalid to trigger validations
          }
        end

        run_test!
      end

      response(401, 'Unauthorized') do
        let(:'Authorization') { nil } # simulate missing token
        let(:bet) do
          {
            game_id: game.id,
            amount: 50.0,
            odds: 1.8,
            bet_type: 'home'
          }
        end

        run_test!
      end
    end
  end

  # ------------------------------------------------------------------
  #  GET /betshistory – Retrieve bet history for current user
  # ------------------------------------------------------------------
  path '/betshistory' do
    get('Retrieve bet history') do
      security [BearerAuth: []]
      tags 'Bets'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer },
            game_id: { type: :integer },
            amount: { type: :number },
            odds: { type: :number },
            bet_type: { type: :string, nullable: true },
            potential_payout: { type: :number },
            status: { type: :string },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime },
            game: {
              type: :object,
              properties: {
                id: { type: :integer },
                home_team: { type: :string },
                away_team: { type: :string },
                score: { type: :string, nullable: true },
                status: { type: :string, nullable: true },
                minute: { type: :integer, nullable: true }
              }
            }
          },
          required: %w[id user_id game_id amount odds status created_at updated_at]
        }

        let(:'Authorization') { "Bearer #{token}" }
        run_test!
      end
    end
  end
end
