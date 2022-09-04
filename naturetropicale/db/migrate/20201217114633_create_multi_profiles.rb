class CreateMultiProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :multi_profiles do |t|
      t.references :admin_job_category, null: false, foreign_key: true
      t.decimal :prix
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
