class AddSoubscriptionToPaiement < ActiveRecord::Migration[6.0]
  def change
    add_column :paiements, :subscription, :boolean, :default => false
  end
end
