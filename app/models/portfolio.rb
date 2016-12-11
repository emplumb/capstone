class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :investment_portfolios
  has_many :investments, through: :inveestment_portfolios

end
