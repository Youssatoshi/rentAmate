class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :bio, length: { maximum: 1000 }
  validates :phone_number, presence: true
  validates :age, presence: true
end
