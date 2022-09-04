class CreateAdminLocationRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_location_regions do |t|
      t.string :name
      t.references :province,foreign_key: { to_table: :admin_location_provinces }, null: false

      t.timestamps
    end
  end
end
