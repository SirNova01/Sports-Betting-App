class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [:login, :logout]

  def login
    service = UserAuthenticationService.new(email: params[:email], password: params[:password])
    result = service.call

    if result[:success]
      render json: { user: UserSerializer.new(result[:user]), token: result[:token] }, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unauthorized
    end
  end

  def logout
    token = request.headers['Authorization']&.split(" ")&.last
    if token
      BlacklistedToken.create(token: token)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { errors: ['Token not provided'] }, status: :bad_request
    end
  end
end
