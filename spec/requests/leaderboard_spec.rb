require 'swagger_helper'

RSpec.describe 'Leaderboard API', type: :request do
  path '/leaderboard' do
    get('Retrieve leaderboard') do
      security [BearerAuth: []]  # This endpoint requires a token.
      tags 'Leaderboard'
      produces 'application/json'
      
      response(200, 'successful') do
        # Provide a valid token via the helper.
        let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
        schema type: :array, items: {
          type: :object,
          properties: {
            user_id:     { type: :integer },
            name:        { type: :string },
            total_payout:{ type: :number }
          },
          required: %w[user_id name total_payout]
        }
        
        run_test!
      end
    end
  end
end
