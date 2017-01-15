class AddSeveralMoreAttributesToIPs < ActiveRecord::Migration[5.0]
  def change
    add_column :investment_portfolios, :alpha, :decimal, precision: 3, scale: 2
    add_column :investment_portfolios, :standard_deviation, :decimal, precision: 4, scale: 2
    add_column :investment_portfolios, :sharpe, :decimal, precision: 3, scale: 2
    add_column :investment_portfolios, :correlation, :decimal, precision: 3, scale: 2
  end
end
