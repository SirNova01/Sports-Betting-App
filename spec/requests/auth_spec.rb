require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  path '/auth/login' do
    post('User login') do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      
      response(200, 'successful login') do
        # Ensure a user exists with these credentials.
        before do
          User.create!(name: 'Test User', email: 'test@example.com', password: 'password')
        end
        
        let(:credentials) { { email: 'test@example.com', password: 'password' } }
        run_test!
      end
      
      response(401, 'unauthorized') do
        before do
          # Create a user so that the email exists, but the password will be incorrect.
          User.create!(name: 'Test User', email: 'test@example.com', password: 'password')
        end
        
        let(:credentials) { { email: 'test@example.com', password: 'wrongpassword' } }
        run_test!
      end
    end
  end

  path '/auth/logout' do
    post('User logout') do
      security [BearerAuth: []]
      tags 'Auth'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token', required: true
      
      response(200, 'successful logout') do
        let(:'Authorization') { "Bearer #{register_user_and_get_token}" }
        run_test!
      end
      
      response(400, 'bad request - token not provided') do
        let(:'Authorization') { nil }
        run_test!
      end
    end
  end
end
