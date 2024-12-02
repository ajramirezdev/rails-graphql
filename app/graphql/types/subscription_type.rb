module Types
  class SubscriptionType < Types::BaseObject
    field :post_created, subscription: Subscriptions::PostCreated
    field :message_created, subscription: Subscriptions::MessageCreated
  end
end
