class InvestmentPortfolio < ApplicationRecord
  belongs_to :investment
  belongs_to :portfolio

  validates :cost_basis, presence: true

  def yesterday
    1.day.ago.strftime("%Y-%m-%d")
  end

  def quandl_yesterday
    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{yesterday}&end_date=#{yesterday}&api_key=AVB8P1K72xSZsU2SyFZN").body
    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=2017-01-13&end_date=2017-01-13&api_key=AVB8P1K72xSZsU2SyFZN").body

    Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}/data.json?start_date=2017-01-13&end_date=2017-01-13&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def current_price
    quandl_yesterday["dataset_data"]["data"][0][1]
  end

  def current_value
    current_price * shares
  end

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

  def gain_loss
    current_value - cost_basis
  end

  def one_month_ago
    1.month.ago.strftime("%Y-%m-%d")
  end

  def quandl_month_ago
    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{one_month_ago}&end_date=#{one_month_ago}&api_key=AVB8P1K72xSZsU2SyFZN").body
    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=2016-12-19&end_date=2016-12-19&api_key=AVB8P1K72xSZsU2SyFZN").body

    Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}/data.json?start_date=2016-12-19&end_date=2016-12-19&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def month_ago_price
    quandl_month_ago["dataset_data"]["data"][0][1]
  end

  def month_ago_value
    month_ago_price * shares
  end

  def one_month_return
    (current_value - month_ago_value) / month_ago_value
  end

  def weighted_month_return
    weighting * one_month_return
  end

  def beginning_year
    (Date.today.beginning_of_year + 2.days).strftime("%Y-%m-%d")
  end

  def quandl_beginning_year
    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}.json?start_date=#{beginning_year}&end_date=#{beginning_year}&api_key=AVB8P1K72xSZsU2SyFZN").body

    # Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}/data.json?start_date={beginning_year}&end_date=#{beginning_year}&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").body
    Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}/data.json?start_date=2017-01-03&end_date=2017-01-03&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def beginning_year_price
    quandl_beginning_year["dataset_data"]["data"][0][1]
  end

  def beginning_year_value
    beginning_year_price * shares
  end

  def ytd_return
    (current_value - beginning_year_value) / beginning_year_value
  end

  def weighted_ytd_return
    weighting * ytd_return
  end

  def six_months_ago
    6.months.ago.strftime("%Y-%m-%d")
  end

  def quandl_six_months_ago
    Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{ticker}/data.json?start_date=2016-07-18&end_date=2016-07-18&column_index=6&order=asc&api_key=AVB8P1K72xSZsU2SyFZN").body
  end

  def six_months_ago_price
    quandl_six_months_ago["dataset_data"]["data"][0][1]
  end

  def six_months_ago_value
    six_months_ago_price * shares
  end

  def six_month_return
    (current_value - six_months_ago_value) / six_months_ago_value
  end

  def weighted_six_month_return
    weighting * six_month_return
  end

  def inception_return
    gain_loss / cost_basis
  end


end
