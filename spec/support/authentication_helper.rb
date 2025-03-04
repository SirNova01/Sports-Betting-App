module AuthenticationHelper
  def register_user_and_get_token
    params = {
      name: "Joe Danny",
      email: "joedanny@gmail.com",
      password: "joe123"
    }
    result = UserRegistrationService.new(params).call
    # Ensure registration was successful before returning the token
    raise "User registration failed: #{result[:errors]}" unless result[:success]
    result[:token]
  end
end
