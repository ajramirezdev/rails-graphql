# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :users, [ UserType ], null: false
    field :user, UserType, null: false do
      argument :id, ID, required: true
    end
    field :posts, [ PostType ], null: false
    field :post, PostType, null: false do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    end
  end
end
