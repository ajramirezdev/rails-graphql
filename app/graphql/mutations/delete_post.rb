class Mutations::DeletePost < Mutations::BaseMutation
  argument :id, ID, required: true

  field :id, ID, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(id:)
    post = Post.find_by(id: id)

    if post.nil?
      { message: nil, errors: [ "Post not found" ] }
    elsif post.destroy
      { id: id, message: "Post successfully deleted.", errors: [] }
    else
      { message: nil, errors: post.errors.full_messages }
    end
  end
end
