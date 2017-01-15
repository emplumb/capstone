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
    @investment = Investment.find_by(ticker: params[:ticker])

    if @ip_present
      redirect_to "/portfolios/#{current_user.portfolios.first.id}"
      flash[:danger] = "Your portfolio already holds this security"
    else
      # input_date = params[:purchase_date]

      input_date_call = Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{params[:ticker]}.json?start_date=#{params[:purchase_date]}&end_date=#{params[:purchase_date]}&api_key=AVB8P1K72xSZsU2SyFZN").body

      input_date_price = input_date_call["dataset"]["data"][0][6]

      # def current_value
      #   current_price * shares
      # end

      share_amount = params[:cost_basis].to_f / input_date_price.to_f
      # share_amount = params[:cost_basis].to_f / params[:purchase_price].to_f
      investment_portfolio = InvestmentPortfolio.new(
        investment_id: @investment.id,
        portfolio_id: current_user.portfolios.first.id,
        cost_basis: params[:cost_basis],
        ticker: params[:ticker],
        # purchase_price: params[:purchase_price],
        purchase_price: @input_date_price,
        purchase_date: params[:purchase_date],
        shares: share_amount
      )
      if investment_portfolio.save
        redirect_to "/portfolios/#{current_user.portfolios.first.id}"
        flash[:success] = "Investment successfully added to your portfolio"
      else
        session[:return_to] ||= request.referer
        flash[:danger] = "You must fill in a dollar amount"
        redirect_to session.delete(:return_to)
      end
    end
  end

  def destroy
    investment_portfolio = InvestmentPortfolio.find(params[:id])
    investment_portfolio.destroy
    redirect_to "/portfolios/#{current_user.portfolios.first.id}"
    flash[:danger] = "Investment removed from portfolio"
  end

end
