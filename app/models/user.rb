class User < ApplicationRecord
  # Include default devise modules and other relevant model setup
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy, autosave: true
  has_many :bookings
  has_one_attached :avatar
  accepts_nested_attributes_for :profile
  after_create :ensure_user_profile

  private

  def ensure_user_profile
    build_profile.save unless profile.present?
  end
end
