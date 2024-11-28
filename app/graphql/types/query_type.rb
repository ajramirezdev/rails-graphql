# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :users, [ UserType ], null: false
    field :user, UserType, null: false do
      argument :id, ID, required: true
    end

    field :posts, [ Types::PostType ], null: false do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end
    field :post, PostType, null: false do
      argument :id, ID, required: true
    end

    field :me, UserType, null: true

    def users
      authenticate_user!
      User.all
    end

    def user(id:)
      User.find(id)
    end

    def posts(limit: nil, offset: nil)
      Post.all.limit(limit).offset(offset).order("updated_at DESC")
    end

    def post(id:)
      Post.find(id)
    end

    def me
      context[:current_user]
    end

    private

      def authenticate_user!
        raise GraphQL::ExecutionError, "User must be logged in." unless context[:current_user]
      end
  end
end
