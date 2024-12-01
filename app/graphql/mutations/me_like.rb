class Mutations::MeLike < Mutations::BaseMutation
  argument :id, Integer, required: true

  field :message, String, null: true

  def resolve(id:)
    user1 = context[:current_user]

    raise GraphQL::ExecutionError, "User must be logged in." unless user1

    user2 = User.find_by(id: id)

    raise GraphQL::ExecutionError, "User not found." unless user2

    like = Like.new(liker: user1, liked: user2)

    if like.save
      reverse_like = Like.find_by(liker: user2, liked: user1)
      if reverse_like
        Match.create(user_1: user1, user_2: user2)
        { message: "It's a match! You and #{user2.first_name} liked each other!" }
      else
        { message: "Liked #{user2.first_name}!" }
      end
    else
      raise GraphQL::ExecutionError, like.errors.full_messages.join(", ")
    end
  end
end
