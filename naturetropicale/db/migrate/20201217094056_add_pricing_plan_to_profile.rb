class AddPricingPlanToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :pricing_plan, :integer
  end
end
