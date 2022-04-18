class Store::CheckoutController < ApplicationController

  def index 
  end 

  def create
    if Customers::CustomerService.cart_exists?(current_user.id)
      redirect_to checkout_path 
    else 
      redirect_to cart_path
    end
  end

  def show 
    @addresses = Customers::CustomerService.get_addresses(current_user.id)
    @cart_items = Cart::CartService.get(current_user)
  end

end
