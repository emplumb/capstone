class Api::V1::PortfoliosController < ApplicationController

  def index
    @portfolios = Portfolio.all
    render "index.json.jbuilder"
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @investment = Investment.find_by(ticker: params[:ticker])
    @investment_portfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)
    render "show.json.jbuilder"
  end

end
