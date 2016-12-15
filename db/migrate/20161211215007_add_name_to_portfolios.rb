class AddNameToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :name, :string
  end
end
