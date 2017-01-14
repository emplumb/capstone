class Investment < ApplicationRecord
  has_many :investment_portfolios
  has_many :portfolios, through: :investment_portfolios

  def quandl
    Unirest.get("https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=2017-01-12&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def current_price
    quandl["dataset"]["data"][0][4]
  end

end
