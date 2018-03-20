class ListingsController < ApplicationController
  def new
  end

  def create
    @listing = Listings.create(user_params)
  end

  def user_params
  params.require(:listing).permit(:image)
  end

end
