class CreateMultiPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :multi_places do |t|
      t.string :adresse
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
