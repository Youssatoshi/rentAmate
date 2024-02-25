class AddRecipientIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :recipient_id, :bigint
  end
end
