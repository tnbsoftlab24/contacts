class CreateFreetimes < ActiveRecord::Migration[6.0]
  def change
    create_table :freetimes do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
