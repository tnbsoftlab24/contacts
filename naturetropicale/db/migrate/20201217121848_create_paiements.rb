class CreatePaiements < ActiveRecord::Migration[6.0]
  def change
    create_table :paiements do |t|
      t.decimal :montant
      t.integer :status
      t.string  :comment
      t.string  :received
      t.boolean :confirmation
      t.datetime :confirmed_at
      t.references :owner, foreign_key: { to_table: :profiles }, index: true
      t.timestamps
    end
  end
end
