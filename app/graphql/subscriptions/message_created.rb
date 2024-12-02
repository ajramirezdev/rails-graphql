module Subscriptions
  class MessageCreated < GraphQL::Schema::Subscription
    field :message, Types::MessageType, null: false
  end
end
