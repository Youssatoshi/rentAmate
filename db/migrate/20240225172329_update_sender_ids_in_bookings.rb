# db/migrate/YYYYMMDDHHMMSS_update_sender_ids_in_bookings.rb

class UpdateSenderIdsInBookings < ActiveRecord::Migration[7.1]
  def up
    Booking.all.each do |booking|
      if booking.user_id == booking.profile.user_id
        # If the user initiated the booking, set sender_id to user_id
        booking.update(sender_id: booking.user_id)
      else
        # Otherwise, set sender_id to profile.user_id
        booking.update(sender_id: booking.profile.user_id)
      end
    end
  end

  def down
    # This migration is irreversible
  end
end
