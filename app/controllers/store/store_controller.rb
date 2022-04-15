class Store::StoreController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @products = Store::StoreService.get_all_products
  end

  def show 
    @product = Store::StoreService.get(params[:id])
  end
end
