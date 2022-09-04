class CreateExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :extras do |t|
      t.string :designation
      t.decimal :prix_entreprise
      t.decimal :prix_employe
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
