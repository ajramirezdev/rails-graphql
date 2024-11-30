class Mutations::CreateUser < Mutations::BaseMutation
  argument :first_name, String
  argument :last_name, String, required: true
  argument :email, String, required: true
  argument :mobile_number, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true
  argument :birthdate, GraphQL::Types::ISO8601Date, required: true
  argument :gender, String, required: true
  argument :sexual_orientation, String, required: true
  argument :gender_interest, String, required: true
  argument :country, String, required: true
  argument :state, String, required: true
  argument :city, String, required: true
  argument :school, String, required: false
  argument :bio, String, required: true
  argument :images, [ String ], required: true

  field :user, Types::UserType, null: true
  field :token, String, null: true
  field :errors, [ String ], null: false

  def resolve(
    first_name:, last_name:, email:, mobile_number:, password:, password_confirmation:,
    birthdate:, gender:, sexual_orientation:, gender_interest:, country:, state:, city:,
    school:, bio:, images:
  )
  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: email,
    mobile_number: mobile_number,
    password: password,
    password_confirmation: password_confirmation,
    birthdate: birthdate,
    gender: gender,
    sexual_orientation: sexual_orientation,
    gender_interest: gender_interest,
    country: country,
    state: state,
    city: city,
    school: school,
    bio: bio,
    images: images
  )

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
