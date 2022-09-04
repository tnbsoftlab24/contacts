class CreateSouscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :souscriptions do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :pricing_plan
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end