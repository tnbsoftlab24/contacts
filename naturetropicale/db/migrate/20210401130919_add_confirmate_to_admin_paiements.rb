class AddConfirmateToAdminPaiements < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_paiements, :confirmate, :boolean
    add_column :admin_paiements, :confirmation_date, :datetime
  end
end
