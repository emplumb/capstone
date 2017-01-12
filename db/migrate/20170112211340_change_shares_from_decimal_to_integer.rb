class ChangeSharesFromDecimalToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :investment_portfolios, :shares, :integer
  end
end
