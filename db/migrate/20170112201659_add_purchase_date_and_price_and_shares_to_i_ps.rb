class AddPurchaseDateAndPriceAndSharesToIPs < ActiveRecord::Migration[5.0]
  def change
    add_column :investment_portfolios, :purchase_price, :decimal, precision: 8, scale: 2
    add_column :investment_portfolios, :purchase_date, :date
    add_column :investment_portfolios, :shares, :decimal, precision: 8, scale: 2
  end
end
