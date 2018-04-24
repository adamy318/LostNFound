class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && authenticate(user, params[:session][:password]) 
      log_in user 
      flash[:success] = "You are now logged in!"
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
      flash[:success] = "You are now logged out!"
    redirect_to root_path
  end

end
