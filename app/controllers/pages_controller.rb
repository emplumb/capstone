class PagesController < ApplicationController

  def index
    @portfolios = Portfolio.order('name ASC')
    render "index.html.erb"
  end

end
