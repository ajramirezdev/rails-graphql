class Mutations::EditUser < Mutations::BaseMutation
  # Define arguments
  argument :id, ID, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :email, String, required: false
  argument :mobile_number, String, required: false
  argument :birthdate, GraphQL::Types::ISO8601Date, required: false
  argument :gender, String, required: false
  argument :sexual_orientation, String, required: false
  argument :gender_interest, String, required: false
  argument :country, String, required: false
  argument :state, String, required: false
  argument :city, String, required: false
  argument :school, String, required: false
  argument :bio, String, required: false
  argument :images, [ String ], required: false

  field :message, String, null: true
  field :errors, [ String ], null: false

  def resolve(id:, **args)
    raise GraphQL::ExecutionError, "You do not have permission to perform this action." unless context[:current_user].admin?

    user = User.find_by(id: id)
    raise GraphQL::ExecutionError, "User not found" unless user

    if user.update(args.compact)
      { message: "User edited successfully", errors: [] }
    else
      { user: nil, errors: user.errors.full_messages }
    end
  end
end
