class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to "/"
      flash[:warning] = "You're already logged in"
    else
      render 'new.html.erb'
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully logged in!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:warning] = 'Successfully logged out!'
    redirect_to '/login'
  end

end
