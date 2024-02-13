class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :profile, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
