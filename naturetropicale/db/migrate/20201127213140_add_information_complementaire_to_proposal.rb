class AddInformationComplementaireToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :information_complementaire, :string
  end
end
