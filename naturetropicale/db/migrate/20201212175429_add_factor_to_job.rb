class AddFactorToJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :factor, :integer
  end
end
