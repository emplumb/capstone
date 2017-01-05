class PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find(params[:id])

    ticker = params[:ticker] || "AAPL"

    @barchart = Unirest.get("http://marketdata.websol.barchart.com/getQuote.json?key=a6ff075b20922ed334cf367cab045322&symbols=#{ticker}").body

    @current_day = @barchart["results"][0]
    @name = @current_day["name"]
    @symbol = @current_day["symbol"]
    @date = @current_day["tradeTimestamp"]
    @current_price = @current_day["lastPrice"]
    @open_price = @current_day["open"]
    @percent_change = @current_day["percentChange"]
  end

end
