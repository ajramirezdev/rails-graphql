class Mutations::CreateUser < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true

  field :user, Types::UserType, null: true
  field :token, String, null: true
  field :errors, [ String ], null: false

  def resolve(name:, email:, password:, password_confirmation:)
    user = User.new(name:, email:, password:, password_confirmation:)

    if user.save
      token = generate_jwt(user)
      { user: user, token: token, errors: [] }
    else
      { user: nil, token: nil, errors: user.errors.full_messages }
    end
  end

  private

  def generate_jwt(user)
    payload = { user_id: user.id, admin: user.admin, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, "my_secret")
  end
end
