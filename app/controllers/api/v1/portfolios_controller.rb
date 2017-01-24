class Api::V1::PortfoliosController < ApplicationController

  def index
    @portfolios = Portfolio.all
    render "index.json.jbuilder"
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @investment_portfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id).order(id: 'DESC')
    render "show.json.jbuilder"
  end

end
