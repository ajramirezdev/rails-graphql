module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :mobile_number, String, null: false
    field :birthdate, GraphQL::Types::ISO8601Date, null: false
    field :gender, String, null: false
    field :sexual_orientation, String, null: false
    field :gender_interest, String, null: false
    field :country, String, null: false
    field :state, String, null: false
    field :city, String, null: false
    field :school, String, null: true
    field :bio, String, null: false
    field :images, [ String ], null: false
    field :admin, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :posts_count, Integer, null: false
    field :posts, [ Types::PostType ], null: false

    field :liked_users, [ Types::UserType ], null: false
    field :matches, [ Types::UserType ], null: false

    def posts_count
      object.posts.size
    end

    def liked_users
      object.liked_users
    end

    def matches
      object.user_matches
    end
  end
end
