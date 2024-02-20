class AddIsListedToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :is_listed, :boolean
  end
end
