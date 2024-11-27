class Mutations::EditPost < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :title, String, required: true
  argument :content, String, required: true

  field :post, Types::PostType, null: true
  field :errors, [ String ], null: true

  def resolve(id:, title:, content:)
    post = Post.find_by(id: id)

    if post.nil?
      return { post: nil, errors: [ "Post not found" ] }
    end

    if post.update(title: title, content: content)
      { post: post, errors: [] }
    else
      { post: nil, errors: post.errors.full_messages }
    end
  end
end
