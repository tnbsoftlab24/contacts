class AddBiographieToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :bio, :string
  end
end
