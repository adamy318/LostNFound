class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def create
  end

end
