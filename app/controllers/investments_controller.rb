class InvestmentsController < ApplicationController

  def index

    @ticker = params[:ticker] || "aapl"

    gon.investment = Investment.find_by(ticker: @ticker)
    @investment = Investment.find_by(ticker: @ticker)

    @barchart = Unirest.get("http://marketdata.websol.barchart.com/getQuote.json?key=a6ff075b20922ed334cf367cab045322&symbols=#{@ticker}").body
    @current_day = @barchart["results"][0]

    @name = @current_day["name"]
    @symbol = @current_day["symbol"]
    @date = @current_day["tradeTimestamp"]
    @current_price = @current_day["lastPrice"]
    @open_price = @current_day["open"]
    @percent_change = @current_day["percentChange"]

    @yahoo = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.quotes+where+symbol+in+('#{@ticker}')&format=json&env=store://datatables.org/alltableswithkeys&callback=").body

    @data = @yahoo["query"]["results"]["quote"]

    @one_year_low = @data["YearLow"]
    @one_year_high = @data["YearHigh"]
    @one_year_target = @data["OneyrTargetPrice"]
    @yield = @data["DividendYield"]
    @ex_div_date = @data["ExDividendDate"]

    @fifty_ma = @data["FiftydayMovingAverage"]
    @two_hundred_ma = @data["TwoHundreddayMovingAverage"]

    @price_earnings = @data["PERatio"]
    @price_sales = @data["PriceSales"]

    @eps = @data["EarningsShare"]
    @eps_quarter_estimate = @data["EPSEstimateNextQuarter"]
    @eps_year_estimate = @data["EPSEstimateCurrentYear"]

  end

  def show
    gon.investment = Investment.find(params[:id])
    @investment = Investment.find_by(id: params[:id])
    @portfolio = Portfolio.where(id: current_user.portfolios.first.id)

    ticker = @investment.ticker

    @barchart = Unirest.get("http://marketdata.websol.barchart.com/getQuote.json?key=a6ff075b20922ed334cf367cab045322&symbols=#{ticker}").body
    @current_day = @barchart["results"][0]

    @name = @current_day["name"]
    @symbol = @current_day["symbol"]
    @date = @current_day["tradeTimestamp"]
    @current_price = @current_day["lastPrice"]
    @open_price = @current_day["open"]
    @percent_change = @current_day["percentChange"]

    @yahoo = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22#{ticker}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=").body
    @data = @yahoo["query"]["results"]["quote"]

    @one_year_low = @data["YearLow"]
    @one_year_high = @data["YearHigh"]
    @one_year_target = @data["OneyrTargetPrice"]
    @yield = @data["DividendYield"]
    @ex_div_date = @data["ExDividendDate"]

    @fifty_ma = @data["FiftydayMovingAverage"]
    @two_hundred_ma = @data["TwoHundreddayMovingAverage"]

    @price_earnings = @data["PERatio"]
    @price_sales = @data["PriceSales"]

    @eps = @data["EarningsShare"]
    @eps_quarter_estimate = @data["EPSEstimateNextQuarter"]
    @eps_year_estimate = @data["EPSEstimateCurrentYear"]

    @shares = params[:cost_basis].to_i / @current_price

    render "show.html.erb"
  end

end
