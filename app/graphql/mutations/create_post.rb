class Mutations::CreatePost < Mutations::BaseMutation
  argument :title, String, required: true
  argument :content, String, required: true

  field :post, Types::PostType, null: true
  field :user, Types::UserType, null: true
  field :errors, [ String ], null: false

  def resolve(title:, content:)
    user = context[:current_user]

    return { post: nil, errors: [ "User must be logged in." ] } unless user

    post = user.posts.new(title:, content:)

    if post.save
      { post: post, user: user, errors: [] }
    else
      { post: nil, user: nil, errors: post.errors.full_messages }
    end
  end
end
