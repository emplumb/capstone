class InvestmentPortfolio < ApplicationRecord
  belongs_to :investment
  belongs_to :portfolio

end
