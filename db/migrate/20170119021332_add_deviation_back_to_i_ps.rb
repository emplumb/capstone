class AddDeviationBackToIPs < ActiveRecord::Migration[5.0]
  def change
    add_column :investment_portfolios, :standard_deviation, :decimal, precision: 4, scale: 4
  end
end
