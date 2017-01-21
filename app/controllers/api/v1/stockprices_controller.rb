class Api::V1::StockpricesController < ApplicationController

  def show
    @investment = Investment.find(params[:id])
    current_date = 1.day.ago.strftime("%Y-%m-%d")

    api_call = Unirest.get("https://www.quandl.com/api/v3/datatables/WIKI/PRICES.json?date.gte=2000-01-01&date.lte=#{current_date}&ticker=#{@investment.ticker}&qopts.columns=date,adj_close&api_key=AVB8P1K72xSZsU2SyFZN").body
    @daily_prices = api_call["datatable"]["data"]

    render "show.json.jbuilder"
  end

  def index
    @investments = Investment.all
    render "index.json.jbuilder"
  end

end