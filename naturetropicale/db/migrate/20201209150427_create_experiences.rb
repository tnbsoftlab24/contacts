class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :description
      t.string :diplome
      t.integer :nb_experience
      t.references :admin_job_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
