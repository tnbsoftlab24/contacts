class AddAdminConfirmationToPaiement < ActiveRecord::Migration[6.0]
  def change
    add_column :paiements, :admin_confirmation, :boolean
  end
end
