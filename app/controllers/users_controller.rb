class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  def create
    service = UserRegistrationService.new(user_params)
    result = service.call

    if result[:success]
      render json: { user: UserSerializer.new(result[:user]), token: result[:token] }, status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
