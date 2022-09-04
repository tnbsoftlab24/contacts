class AddTimeZoneToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :quartier, :string
  end
end
