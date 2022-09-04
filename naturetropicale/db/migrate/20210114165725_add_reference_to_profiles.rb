class AddReferenceToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :reference, :string
  end
end
