module Subscriptions
  class BaseSubscription < GraphQL::Schema::Subscription
    object_class Types::BaseObject
    field_class Types::BaseField
    argument_class Types::BaseArgument

    def current_user
      context[:current_user]
    end
  end
end
