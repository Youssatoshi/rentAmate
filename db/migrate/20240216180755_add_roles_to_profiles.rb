class AddRolesToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :roles, :string
  end
end
