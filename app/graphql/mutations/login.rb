class Mutations::Login < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  field :token, String, null: true
  field :errors, [ String ], null: false

  def resolve(email:, password:)
    user = User.find_by(email: email)

    if user&.authenticate(password)
      token = generate_jwt(user)
      { token: token, errors: [] }
    else
      { token: nil, errors: [ "Invalid email or password" ] }
    end
  end

  private

    def generate_jwt(user)
      payload = { user_id: user.id, admin: user.admin, exp: 24.hours.from_now.to_i }
      JWT.encode(payload, "my_secret")
    end
end
