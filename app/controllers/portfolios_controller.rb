class PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])
    @investment = Investment.find_by(ticker: params[:ticker])
    @investment_portfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)
    @investments = Investment.all

    gon.investmentPortfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)

    if current_user
        @portfolio = current_user.portfolios
        render "show.html.erb"
    else
        redirect_to "/"
    end
  end

  def new
    if current_user
        @portfolio = Portfolio.new
        render "new.html.erb"
    else
        redirect_to "/login"
        flash[:warning] = "You must be logged in to continue"
    end
  end

  def create
    portfolio = Portfolio.new(
        name: params[:name],
        user_id: current_user.id
    )
    portfolio.save
    redirect_to "/investments"
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.destroy
        flash[:danger] = "Your portfolio was successfully deleted"
        redirect_to "/"
    end
  end

end
