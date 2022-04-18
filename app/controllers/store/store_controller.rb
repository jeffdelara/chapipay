class Store::StoreController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @products = Products::ProductService.all_in_stock
  end

  def show 
    @product = Products::ProductService.find(params[:id])
  end
end
