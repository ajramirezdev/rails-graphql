class Mutations::DeletePost < Mutations::BaseMutation
  argument :id, ID, required: true

  field :id, ID, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(id:)
    user = context[:current_user]

    return { post: nil, message: nil, errors: [ "User must be logged in." ] } unless user

    post = Post.find_by(id: id)

    return { id: nil, message: nil, errors: [ "You cannot delete this post." ] } unless post && (user == post.user || user.admin?)

    if post.destroy
      { id: id, message: "Post successfully deleted.", errors: [] }
    else
      { id: nil, message: nil, errors: [ "Failed to delete post." ] }
    end
  end
end
