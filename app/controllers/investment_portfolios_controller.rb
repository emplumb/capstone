class InvestmentPortfoliosController < ApplicationController

  def index
    @investment_portfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)

    if @investment_portfolios.length > 0
      render "index.html.erb"
    else
      redirect_to "/"
      flash[:warning] = "You must be logged in to add investments to your portfolio"
    end
  end

  def create
    @ip_present = InvestmentPortfolio.find_by(investment_id: params[:investment_id], portfolio_id: current_user.portfolios.first.id)
    @share_amount = params[:cost_basis].to_f / @current_price.to_f

    if @ip_present
      redirect_to "/portfolios/#{current_user.portfolios.first.id}"
      flash[:danger] = "Your portfolio already holds this security"
    else
      investment_portfolio = InvestmentPortfolio.new(
        investment_id: params[:investment_id],
        portfolio_id: current_user.portfolios.first.id,
        cost_basis: params[:cost_basis],
        shares: @share_amount
      )
      investment_portfolio.save
      redirect_to "/portfolios/#{current_user.portfolios.first.id}"
      flash[:success] = "Investment successfully added to your portfolio"
    end
  end

  def destroy
    investment_portfolio = InvestmentPortfolio.find(params[:id])
    investment_portfolio.destroy
    redirect_to "/portfolios/#{current_user.portfolios.first.id}"
    flash[:danger] = "Investment removed from portfolio"
  end

end
