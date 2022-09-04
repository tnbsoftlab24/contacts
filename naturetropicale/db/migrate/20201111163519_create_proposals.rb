class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.references :job, foreign_key: { to_table: :jobs }, null: false
      t.references :owner, foreign_key: { to_table: :profiles }, null: false
      t.timestamps
    end
  end
end
