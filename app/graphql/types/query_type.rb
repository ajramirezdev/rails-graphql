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

    field :postsCount, Integer, null: false

    field :me, UserType, null: true

    field :findMatch, [ UserType ], null: false do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    field :likedUsers, [ UserType ], null: false
    field :myMatches, [ UserType ], null: false

    field :matchCount, Integer, null: false

    def users
      authenticate_admin!
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

    def postsCount
      Post.count
    end

    def me
      context[:current_user]
    end

    def findMatch(limit: nil, offset: nil)
      authenticate_user!

      current_user = context[:current_user]
      gender = current_user.gender
      gender_interest = current_user.gender_interest

      matches = User.where(gender: gender_interest)
                .where(gender_interest: gender)
                .where.not(id: current_user.id)

      matches = matches.limit(limit).offset(offset) if limit || offset

      matches
    end

    def matchCount
      authenticate_user!

      current_user = context[:current_user]
      gender = current_user.gender
      gender_interest = current_user.gender_interest

      User.where(gender: gender_interest)
        .where(gender_interest: gender)
        .where.not(id: current_user.id).count
    end

    def likedUsers
      user = context[:current_user]
      return [] unless user
      user.liked_users
    end

    def myMatches
      user = context[:current_user]
      return [] unless user
      user.user_matches
    end

    private

      def authenticate_user!
        raise GraphQL::ExecutionError, "User must be logged in." unless context[:current_user]
      end

      def authenticate_admin!
        raise GraphQL::ExecutionError, "User must be logged in." unless context[:current_user]
        raise GraphQL::ExecutionError, "You do not have permission to perform this action." unless context[:current_user].admin?
      end
  end
end
