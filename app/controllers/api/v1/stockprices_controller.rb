class Api::V1::StockpricesController < ApplicationController

  def show
    @investment = Investment.find(params[:id])
    current_date = 1.day.ago.strftime("%Y-%m-%d")

    Unirest.timeout(5)
    5.times do
      api_call = Unirest.get("https://www.quandl.com/api/v3/datasets/YAHOO/#{@investment.ticker}/data.json?start_date=2006-01-01&column_index=6&order=asc&api_key=#{ENV['quandl_api_one']}").body


      if api_call["dataset_data"]
        @daily_prices = api_call["dataset_data"]["data"]
        render 'show.json.jbuilder'
        return
      else
        puts "*" * 40
        puts "problem with #{@investment.ticker}, retrying..."
        puts "*" * 40
      end
    end

    render "show.json.jbuilder"
  end

  def index
    @investments = Investment.all
    render "index.json.jbuilder"
  end

end
