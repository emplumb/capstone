class RemoveColumnsFromPortfolios < ActiveRecord::Migration[5.0]
  def change
    remove_column :portfolios, :standard_deviation, :decimal, precision: 4, scale: 2
    remove_column :portfolios, :alpha, :decimal, precision: 3, scale: 2
    remove_column :portfolios, :month_return, :decimal, precision: 6, scale: 2
  end
end
