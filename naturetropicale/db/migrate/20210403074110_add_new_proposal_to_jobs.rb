class AddNewProposalToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :new_proposal, :boolean
  end
end
