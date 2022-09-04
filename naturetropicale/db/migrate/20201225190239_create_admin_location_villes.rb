class CreateAdminLocationVilles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_location_villes do |t|
      t.string :name
      t.references :region, foreign_key: { to_table: :admin_location_regions }, null: false

      t.timestamps
    end
  end
end
