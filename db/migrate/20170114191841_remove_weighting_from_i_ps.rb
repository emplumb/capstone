class RemoveWeightingFromIPs < ActiveRecord::Migration[5.0]
  def change
    remove_column :investment_portfolios, :weighting, :decimal, precision: 3, scale: 2
  end
end
