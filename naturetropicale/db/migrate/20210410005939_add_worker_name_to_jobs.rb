class AddWorkerNameToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :worker_name, :string
  end
end
