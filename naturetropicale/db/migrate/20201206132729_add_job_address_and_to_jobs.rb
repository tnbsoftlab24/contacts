class AddJobAddressAndToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :taux, :boolean
    add_column :jobs, :job_adress, :string
  end
end
