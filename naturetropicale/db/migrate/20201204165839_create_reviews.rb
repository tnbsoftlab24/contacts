class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.references :job, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.decimal :rate

      t.timestamps
    end
  end
end
