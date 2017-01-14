class AddTickerToInvestmentPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :investment_portfolios, :ticker, :string
  end
end
