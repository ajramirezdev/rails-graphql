class Mutations::CreatePost < Mutations::BaseMutation
  argument :title, String, required: true
  argument :content, String, required: true

  field :post, Types::PostType, null: false
  field :errors, [ String ], null: false

  def resolve(title:, content:)
    # user = context[:current_user]
    # return { post: nil, errors: ['User must be logged in.'] } unless user
    user = User.first
    post = user.posts.new(title:, content:)

    if post.save
      { post: post, errors: [] }
    else
      { post: nil, errors: post.errors.full_messages }
    end
  end
end
