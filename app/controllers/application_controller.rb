class ApplicationController < ActionController::API
  before_action :authorize_request

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      return nil if BlacklistedToken.exists?(token: token)
      begin
        JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    if header.present?
      token = header.split(' ').last
      begin
        decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
        @current_user = User.find(decoded[0]['user_id'])
      rescue JWT::DecodeError
        render json: { errors: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { errors: 'Missing token' }, status: :unauthorized
    end
  end
  
end
