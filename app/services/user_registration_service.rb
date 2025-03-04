
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
    # Use slice or permit depending on your preference
    @params.slice(:name, :email, :password)
  end

  def encode_token(user_id)
    payload = { user_id: user_id }
    # Use Rails' secret_key_base or credentials for production apps
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end


