class AddDollarAmountToInvestmentPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :investment_portfolios, :dollar_amount, :decimal, precision: 10, scale: 2
  end
end
