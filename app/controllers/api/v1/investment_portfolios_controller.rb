class Api::V1::InvestmentPortfoliosController < ApplicationController

  def index
    @investment_portfolios = InvestmentPortfolio.all
    render "index.json.jbuilder"
  end

  def show
    @investment_portfolio = InvestmentPortfolio.find(params[:id])
    render "show.json.jbuilder"
  end

  def create
    investment = Investment.find_by(ticker: params[:ticker])
    @investment_portfolio = InvestmentPortfolio.new(
      investment_id: investment.id,
      # investment_id: params[:investmentId],
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
      render "show.json.jbuilder"
    else
      render json: { errors: "Evan broke it" }
    end
  end

end
