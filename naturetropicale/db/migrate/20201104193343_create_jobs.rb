class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :poste
      t.text :description
      t.text :information_specifique
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.references :owner, foreign_key: { to_table: :profiles }, null: false
      t.references :admin_job_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
