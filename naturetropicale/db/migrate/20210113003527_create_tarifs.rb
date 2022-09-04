class CreateTarifs < ActiveRecord::Migration[6.0]
  def change
    create_table :tarifs do |t|
      t.references :admin_job_category, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.decimal :prix

      t.timestamps
    end
  end
end
