class RemovePriceFromInvestments < ActiveRecord::Migration[5.0]
  def change
    remove_column :investments, :price, precision: 8, scale: 2
  end
end
