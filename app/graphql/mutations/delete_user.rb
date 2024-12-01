class Mutations::DeleteUser < Mutations::BaseMutation
  argument :id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: false

  def resolve(id:)
    raise GraphQL::ExecutionError, "You do not have permission to perform this action." unless context[:current_user]&.admin?

    user = User.find_by(id: id)
    raise GraphQL::ExecutionError, "User with ID #{id} not found" unless user

    ActiveRecord::Base.transaction do
      Like.where(liker_id: id).destroy_all

      Match.where("user_1_id = ? OR user_2_id = ?", id, id).destroy_all

      user.destroy!
    end

    { message: "User and associated data deleted successfully", errors: [] }
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e
    raise GraphQL::ExecutionError, "Failed to delete user: #{e.message}"
  end
end
