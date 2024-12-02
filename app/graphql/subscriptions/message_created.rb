module Subscriptions
  class MessageCreated < GraphQL::Schema::Subscription
    field :message, Types::MessageType, null: false

    # This will be called to push the message to subscribed clients
    def update(message:)
      { message: message }
    end

    # This is the trigger that notifies all subscribers when a new message is created
    def self.trigger(message)
      # For example, broadcast to the correct match channel
      ActionCable.server.broadcast("match_#{message.match.id}_channel", { message: message })
    end
  end
end
