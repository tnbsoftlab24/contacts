class CreateAdminLocationProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_location_provinces do |t|
      t.string :name

      t.timestamps
    end
  end
end
