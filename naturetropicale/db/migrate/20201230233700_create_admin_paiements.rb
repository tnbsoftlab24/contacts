class CreateAdminPaiements < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_paiements do |t|
      t.decimal :montant
      t.integer :status
      t.string  :comment
      t.string  :received
      t.references :owner, foreign_key: { to_table: :profiles }, index: true

      t.timestamps
    end
  end
end
