require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    post('Create a user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name:     { type: :string },
          email:    { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }
      
      response(201, 'user created') do
        # Define the expected response schema.
        schema type: :object, properties: {
          user: {
            type: :object,
            properties: {
              id:    { type: :integer },
              name:  { type: :string },
              email: { type: :string }
            },
            required: %w[id name email]
          },
          token: { type: :string }
        }
        
        let(:user) { { name: 'Test User', email: 'test@example.com', password: 'password' } }
        run_test!
      end
      
      response(422, 'unprocessable entity') do
        let(:user) { { name: '', email: 'invalid', password: '' } }
        run_test!
      end
    end
  end
end
