class AddTotalAmountToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :total_amount, :decimal, :default => 0
    add_column :profiles, :total_paiement, :decimal, :default => 0
    add_column :profiles, :tolal_remuneration, :decimal, :default => 0
    add_column :profiles, :total_facturation, :decimal, :default => 0
  end
end
