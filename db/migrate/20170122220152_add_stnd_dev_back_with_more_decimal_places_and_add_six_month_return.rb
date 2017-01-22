class AddStndDevBackWithMoreDecimalPlacesAndAddSixMonthReturn < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :standard_deviation, :decimal, precision: 5, scale: 4
    add_column :portfolios, :six_month_return, :decimal, precision: 6, scale: 2
  end
end
