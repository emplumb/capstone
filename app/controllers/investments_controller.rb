class InvestmentsController < ApplicationController

  def index
    ticker = params[:ticker] || "AMZN"

    # @yahoo = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22#{ticker}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=").body
    # @investment = @yahoo["query"]["results"]["quote"]
    # @ticker = @investment["symbol"].upcase
    # @price = @investment["LastTradePriceOnly"]

    @quandl = Unirest.get("https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}/data.json").body
    @date = @quandl["dataset_data"]["data"][0][0]
    @newdate = Time.now.strftime("%m/%d/%Y")
    @price = @quandl["dataset_data"]["data"][0][11]

    @description = @quandl["dataset_data"]["description"]



  end

  def show
    # @investment = Investment.find(params[:id])


    @investment = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22AMZN%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=").body



    render "show.html.erb"
  end

end
