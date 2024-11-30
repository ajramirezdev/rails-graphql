class Mutations::EditMe < Mutations::BaseMutation
  # Define arguments
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

  # Define fields
  field :user, Types::UserType, null: true
  field :errors, [ String ], null: false

  # Resolve method
  def resolve(**args)
    user = context[:current_user]

    # Ensure user is authenticated
    if user.nil?
      raise GraphQL::ExecutionError, "User must be logged in to edit their profile."
    end

    # Attempt to update the user with the provided arguments
    if user.update(args.compact) # `compact` removes nil values
      { user: user, errors: [] }
    else
      { user: nil, errors: user.errors.full_messages }
    end
  end
end
