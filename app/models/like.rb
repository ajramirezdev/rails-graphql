class Like < ApplicationRecord
  belongs_to :liker, class_name: "User", foreign_key: "liker_id"
  belongs_to :liked, class_name: "User", foreign_key: "liked_id"

  has_one :match, ->(like) {
    where("(user_1_id = ? AND user_2_id = ?) OR (user_1_id = ? AND user_2_id = ?)",
          like.liker_id, like.liked_id, like.liked_id, like.liker_id)
  }

  validates :liker_id, presence: true
  validates :liked_id, presence: true
  validates :liker_id, uniqueness: { scope: :liked_id, message: "You have already liked this user." }
end
