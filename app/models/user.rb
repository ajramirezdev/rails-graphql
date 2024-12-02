class User < ApplicationRecord
  has_many :sent_messages, class_name: "Message", foreign_key: "user_id", dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :sent_likes, class_name: "Like", foreign_key: "liker_id", dependent: :destroy
  has_many :received_likes, class_name: "Like", foreign_key: "liked_id", dependent: :destroy

  has_many :liked_users, through: :sent_likes, source: :liked
  has_many :likers, through: :received_likes, source: :liker

  has_many :matches_as_user_1, class_name: "Match", foreign_key: "user_1_id"
  has_many :matches_as_user_2, class_name: "Match", foreign_key: "user_2_id"

  has_many :matches, -> { distinct }, through: :matches_as_user_1, source: :user_2
  has_many :reverse_matches, -> { distinct }, through: :matches_as_user_2, source: :user_1

  validates :first_name, :last_name, :email, :mobile_number, :birthdate,
            :gender, :sexual_orientation, :gender_interest, :country,
            :state, :city, :bio, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :images, length: { in: 1..5, message: "must have between 1 and 5 photos" }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def user_matches
    User.where(id: matches_as_user_1.select(:user_2_id)).or(User.where(id: matches_as_user_2.select(:user_1_id)))
  end

  private

    def password_required?
      password.present? || new_record?
    end
end
