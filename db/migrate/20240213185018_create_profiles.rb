class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :phone_number
      t.string :address
      t.string :profile_picture_url
      t.integer :age

      t.timestamps
    end
  end
end
