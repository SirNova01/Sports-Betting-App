class UserAuthenticationService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      token = encode_token(user.id)
      { success: true, user: user, token: token }
    else
      { success: false, errors: ['Invalid email or password'] }
    end
  end

  private

  attr_reader :email, :password

  def encode_token(user_id)
    payload = { user_id: user_id }
    # Use Rails' secret_key_base (or credentials) for production
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
