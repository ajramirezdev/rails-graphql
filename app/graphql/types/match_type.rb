module Types
  class MatchType < Types::BaseObject
    field :id, ID, null: false
    field :user_1, Types::UserType, null: false
    field :user_2, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
