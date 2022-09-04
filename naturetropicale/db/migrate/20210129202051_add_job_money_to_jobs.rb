class AddJobMoneyToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :job_money, :decimal
    add_column :jobs, :employee_money, :decimal
  end
end
