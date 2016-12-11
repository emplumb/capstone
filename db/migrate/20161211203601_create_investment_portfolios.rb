class CreateInvestmentPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :investment_portfolios do |t|
      t.integer :investment_id
      t.integer :portfolio_id

      t.timestamps
    end
  end
end
