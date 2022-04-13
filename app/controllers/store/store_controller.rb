class Store::StoreController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @products = Store::StoreService.get_all_products
  end
end
