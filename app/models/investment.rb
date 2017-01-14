class Investment < ApplicationRecord
  has_many :investment_portfolios
  has_many :portfolios, through: :investment_portfolios

end
