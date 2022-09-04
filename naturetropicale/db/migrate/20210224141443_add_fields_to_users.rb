class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_new, :boolean
    add_column :users, :is_validate, :boolean
  end
end
