class InvestmentsController < ApplicationController

  def show
    @investment = Investment.find(params[:id])
    render "show.html.erb"
  end

end
