class PagesController < ApplicationController

  def index
    @users = User.order('name ASC')
    render "index.html.erb"
  end


end
