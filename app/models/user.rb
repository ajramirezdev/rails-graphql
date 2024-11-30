class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, :last_name, :email, :mobile_number, :birthdate,
            :gender, :sexual_orientation, :gender_interest, :country,
            :state, :city, :bio, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :images, length: { in: 1..5, message: "must have between 1 and 5 photos" }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  private

    def password_required?
      password.present? || new_record?
    end
end
