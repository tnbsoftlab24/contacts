class ChangeColumnToNewFromJobs < ActiveRecord::Migration[6.0]
  change_table :jobs do |table|
    table.change :job_money, :decimal
    table.change :employee_money, :decimal
  end
end
