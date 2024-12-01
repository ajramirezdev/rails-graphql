class Mutations::MeDeleteLike < Mutations::BaseMutation
  argument :id, Integer, required: true

  field :message, String, null: true

  def resolve(id:)
    user1 = context[:current_user]
    raise GraphQL::ExecutionError, "User must be logged in." unless user1

    user2 = User.find_by(id: id)
    raise GraphQL::ExecutionError, "User not found." unless user2

    like = Like.find_by(liker: user1, liked: user2)
    raise GraphQL::ExecutionError, "Like not found." unless like

    match = Match.find_by("(user_1_id = ? AND user_2_id = ?) OR (user_1_id = ? AND user_2_id = ?)",
            user1.id, user2.id, user2.id, user1.id)

    if match
      match.destroy
    end

    if like.destroy
      { message: "Unliked #{user2.first_name}." + (match ? " Match removed." : "") }
    else
      raise GraphQL::ExecutionError, "Unable to delete like."
    end
  end
end
