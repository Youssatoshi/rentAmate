class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :bio, length: { maximum: 1000 }
  validates :phone_number, presence: true
  validates :age, presence: true
end
