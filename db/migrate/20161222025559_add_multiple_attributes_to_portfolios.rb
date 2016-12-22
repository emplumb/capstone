class AddMultipleAttributesToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :month_return, :decimal, precision: 6, scale: 2
    add_column :portfolios, :ytd_return, :decimal, precision: 6, scale: 2
    add_column :portfolios, :inception_return, :decimal, precision: 6, scale: 2
    add_column :portfolios, :alpha, :decimal, precision: 3, scale: 2
    add_column :portfolios, :standard_deviation, :decimal, precision: 4, scale: 2
    add_column :portfolios, :sharpe, :decimal, precision: 3, scale: 2
    add_column :portfolios, :correlation, :decimal, precision: 3, scale: 2
  end
end
