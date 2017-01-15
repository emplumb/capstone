class InvestmentPortfolio < ApplicationRecord
  belongs_to :investment
  belongs_to :portfolio

  validates :cost_basis, presence: true

  def yesterday
    2.days.ago.strftime("%Y-%m-%d")
  end

  def quandl_yesterday
    Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{yesterday}&end_date=#{yesterday}&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def current_price
    quandl_yesterday["dataset"]["data"][0][6]
  end

  def current_value
    current_price * shares
  end

  # def gain_loss
  #   current_value - cost_basis
  # end

  # def inception_return
  #   gain_loss / current_value
  # end

  # def one_month_ago
  #   1.month.ago.strftime("%Y-%m-%d")
  # end

  # def quandl_month_ago
  #   Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{one_month_ago}&end_date=#{one_month_ago}&api_key=AVB8P1K72xSZsU2SyFZN").body
  # end

  # def month_ago_price
  #   quandl_month_ago["dataset"]["data"][0][6]
  # end

  # def month_ago_value
  #   month_ago_price * shares
  # end

  # def one_month_return
  #   (current_value - month_ago_value) / month_ago_value
  # end

  # def beginning_year
  #   (Date.today.beginning_of_year + 2.days).strftime("%Y-%m-%d")
  # end

  # def quandl_beginning_year
  #   Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{beginning_year}&end_date=#{beginning_year}&api_key=AVB8P1K72xSZsU2SyFZN").body
  # end

  # def beginning_year_price
  #   quandl_beginning_year["dataset"]["data"][0][4]
  # end

  # def beginning_year_value
  #   beginning_year_price * shares
  # end

  # def ytd_return
  #   (current_value - beginning_year_value) / beginning_year_value
  # end

  def all_portfolios
    portfolio.user.portfolios
  end

  def related_investment_portfolios
    InvestmentPortfolio.where(portfolio_id: all_portfolios.first.id)
  end

  def total_portfolio_value
    related_investment_portfolios.sum(&:current_value)
  end

  def weighting
    current_value / total_portfolio_value
  end

end
