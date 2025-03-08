class UserRegistrationService
  def initialize(params)
    @params = params
  end

  def call
    user = User.new(user_params)
    if user.save
      token = encode_token(user.id)
      { success: true, user: user, token: token }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  private

  def user_params
    @params.slice(:name, :email, :password)
  end

  def encode_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end


