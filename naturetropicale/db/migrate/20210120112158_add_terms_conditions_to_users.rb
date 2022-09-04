class AddTermsConditionsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :terms_conditions, :boolean
  end
end
