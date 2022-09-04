class AddCountryToMultiPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :multi_places, :adresse1, :string
    add_column :multi_places, :adresse2, :string
    add_column :multi_places, :country, :string
    add_column :multi_places, :province, :string
    add_column :multi_places, :ville, :string
    add_column :multi_places, :region, :string
    add_column :multi_places, :code_postal, :string
  end
end
