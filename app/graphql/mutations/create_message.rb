class Mutations::CreateMessage < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :content, String, required: true

  field :message, Types::MessageType, null: true
  field :errors, [ String ], null: false

  def resolve(user_id:, content:)
    user1 = context[:current_user]
    raise GraphQL::ExecutionError, "User must be logged in." unless user1

    user2 = User.find_by(id: user_id)
    raise GraphQL::ExecutionError, "User not found." unless user2

    match = Match.find_by(
      "(user_1_id = ? AND user_2_id = ?) OR (user_1_id = ? AND user_2_id = ?)",
      user1.id, user2.id, user2.id, user1.id
    )
    raise GraphQL::ExecutionError, "Match not found." unless match

    message = match.messages.new(user: user1, content:)

    if message.save
      Subscriptions::MessageCreated.trigger(message)
      { message:, errors: [] }
    else
      { message: nil, errors: message.errors.full_messages }
    end
  end
end
