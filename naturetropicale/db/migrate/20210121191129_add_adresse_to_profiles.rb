class AddAdresseToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :adresse, :string
  end
end
