class PagesController < ApplicationController

  def index
    @portfolios = Portfolio.all
    gon.investmentPortfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)
    render "index.html.erb"
  end

end
