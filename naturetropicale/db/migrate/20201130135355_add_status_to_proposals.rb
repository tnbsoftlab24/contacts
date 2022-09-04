class AddStatusToProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :status, :integer
  end
end
