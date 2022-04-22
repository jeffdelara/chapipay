class Store::PaymentsController < ApplicationController
  def index
    @address = current_user.addresses.find_by(:id => address_params[:id])
    
    unless @address 
      @address = current_user.addresses.create(address_params)
    end

    @cart_items = Cart::CartService.get(current_user)
  end

  def show
  end

  

  private

  def address_params
    params.require(:address).permit(
      :id, 
      :house_number, 
      :street, 
      :town, 
      :city, 
      :state, 
      :country, 
      :zip_code, 
      :mobile_number
    )
  end

end
