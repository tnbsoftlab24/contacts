class AddWorkerIdToAdminPaiements < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_paiements, :worker_id, :integer
    add_reference :admin_paiements, :job, foreign_key: { to_table: :admin_paiements }, index: true
    add_column :admin_paiements, :paiement_date, :datetime
    add_column :admin_paiements, :worker_amount, :decimal
    add_column :admin_paiements, :job_amount, :decimal
    rename_column :admin_paiements, :owner_id, :enterprise_id
  end
end
