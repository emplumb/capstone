class PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])
    @investment_portfolios = InvestmentPortfolio.where(portfolio_id: current_user.portfolios.first.id)

    @total_gain_loss = 0
    @total_portfolio_cost = 0
    @current_portfolio_value = 0

    @investment_portfolios.each do |investment_portfolio|
        @total_portfolio_cost += investment_portfolio.cost_basis
        @current_portfolio_value += (investment_portfolio.shares*investment_portfolio.investment.current_price)
        @total_gain_loss += investment_portfolio.gain_loss
    end

    @inception_portfolio_return = @total_gain_loss / @total_portfolio_cost

    # if current_user
    #     @portfolio = current_user.portfolios
    #     render "show.html.erb"
    # else
    #     redirect_to "/"
    # end

    if params[:ticker]
        ticker = params[:ticker]
        @barchart = Unirest.get("http://marketdata.websol.barchart.com/getQuote.json?key=a6ff075b20922ed334cf367cab045322&symbols=#{ticker}").body

        @current_day = @barchart["results"][0]
        @name = @current_day["name"]
        @symbol = @current_day["symbol"]
        @date = @current_day["tradeTimestamp"]
        @current_price = @current_day["lastPrice"]
        @open_price = @current_day["open"]
        @percent_change = @current_day["percentChange"]
    end

    @investment = Investment.where(ticker: params[:ticker])
    # @investment_portfolio = @portfolio.investment_portfolios.investment_id
    # @port = Portfolio.where(name: "Zora93 Portfolio")

    # @investment_portfolio = InvestmentPortfolio.where(portfolio_id: @portfolio.id, investment_id: @investment.id)
    # @i = @investment_portfolio.investment_id


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
    redirect_to "/portfolios/#{portfolio.id}"
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.destroy
        flash[:danger] = "Your portfolio was successfully deleted"
        redirect_to "/"
    end
  end

end
