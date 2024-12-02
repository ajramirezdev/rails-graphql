module Subscriptions
  class PostCreated < BaseSubscription
    field :post, Types::PostType, null: false
  end
end
