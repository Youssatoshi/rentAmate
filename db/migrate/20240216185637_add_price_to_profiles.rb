class AddPriceToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :price, :integer
  end
end
