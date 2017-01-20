class Api::V1::InvestmentPortfoliosController < ApplicationController

  def index
    @investment_portfolios = InvestmentPortfolio.order(portfolio_id: 'DESC')
    render "index.json.jbuilder"
  end

end
