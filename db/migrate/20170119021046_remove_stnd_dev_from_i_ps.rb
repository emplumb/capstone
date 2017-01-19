class RemoveStndDevFromIPs < ActiveRecord::Migration[5.0]
  def change
    remove_column :investment_portfolios, :standard_deviation, :decimal, precision: 4, scale: 2
  end
end
