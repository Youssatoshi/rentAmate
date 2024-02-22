class Booking < ApplicationRecord
  belongs_to :profile
  belongs_to :user
  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time
  validate :no_overlap
  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected', canceled: 'canceled' }

  private

  def no_overlap
    overlaps = profile.bookings.where.not(id: id).where('start_time < ? AND end_time > ?', end_time, start_time)
    errors.add(:base, 'Slot has already been booked') if overlaps.exists?
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
