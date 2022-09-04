class AddVilleToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :ville, :string
    add_column :jobs, :province, :string
    add_column :jobs, :region, :string
  end
end
