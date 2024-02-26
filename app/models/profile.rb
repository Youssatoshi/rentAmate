class Profile < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :bio, length: { maximum: 1000 }
  validates :phone_number, presence: true
  validates :age, presence: true
end
