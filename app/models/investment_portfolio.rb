class InvestmentPortfolio < ApplicationRecord
  belongs_to :investment
  belongs_to :portfolio

  def date
    2.days.ago.strftime("%Y-%m-%d")
  end

  def quandl
    Unirest.get("https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{date}&end_date=#{date}&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def current_price
    quandl["dataset"]["data"][0][4]
  end

  def current_value
    current_price * shares
  end

  def gain_loss
    current_value - cost_basis
  end

  def inception_return
    gain_loss / current_value
  end

end
