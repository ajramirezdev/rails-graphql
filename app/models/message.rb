class Message < ApplicationRecord
  # after_create :trigger_comment_posted_event
  belongs_to :match
  belongs_to :user

  validates :content, presence: true

  # def trigger_message_created_event
  #   MySchema.subscriptions.trigger("messageCreated", {}, { message: self })
  # end
end
