class AddAmountEmployeeToAdminJobCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_job_categories, :amount_employee, :decimal
  end
end
