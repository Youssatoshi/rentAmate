class AddSenderToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :sender_id, :bigint, null: false, default: 0  # Change the default value as needed
  end
end
