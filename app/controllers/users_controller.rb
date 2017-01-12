class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    render "show.html.erb"
  end

  def new
    if current_user
      redirect_to "/"
      flash[:warning] = "You're already logged in"
    else
      render 'new.html.erb'
    end
  end

  def create
    user = User.new(username: params[:username], name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

end
