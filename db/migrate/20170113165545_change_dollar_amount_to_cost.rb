class ChangeDollarAmountToCost < ActiveRecord::Migration[5.0]
  def change
    rename_column :investment_portfolios, :dollar_amount, :cost_basis
  end
end
