class Api::V1::InvestmentsController < ApplicationController

  def index
    @investments = Investment.all
    render "index.json.jbuilder"
  end

  def show
    @investment = Investment.find(params[:id])
    render "show.json.jbuilder"
  end

end
