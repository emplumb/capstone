class InvestmentPortfolio < ApplicationRecord
  belongs_to :investment
  belongs_to :portfolio

  def gain_loss
    (shares*32) - (shares*purchase_price)
  end

  def inception_return
    gain_loss / (shares*purchase_price)
  end

end
