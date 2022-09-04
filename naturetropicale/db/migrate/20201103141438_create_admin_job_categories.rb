class CreateAdminJobCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_job_categories do |t|
      t.string :title
      t.decimal :amount
      t.references  :parent, index: true

      t.timestamps
    end
  end
end
