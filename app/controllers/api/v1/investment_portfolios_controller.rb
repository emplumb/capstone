class Api::V1::InvestmentPortfoliosController < ApplicationController

  def index
    @investment_portfolios = InvestmentPortfolio.order(portfolio_id: 'DESC')
    render "index.json.jbuilder"
  end

  def create
    @investment_portfolio = InvestmentPortfolio.new(
      investment_id: params[:investmentId],
      portfolio_id: params[:portfolioId],
      cost_basis: params[:costBasis],
      ticker: params[:ticker],
      purchase_price: params[:purchasePrice],
      purchase_date: params[:purchaseDate],
      shares: params[:shares],
      standard_deviation: params[:standardDeviation],
      sharpe: params[:sharpe],
      correlation: params[:correlation]
    )
    if @investment_portfolio.save
      render "index.json.jbuilder"
    else
      render json: { errors: "Peter Jang broke it" }
    end
  end

end
