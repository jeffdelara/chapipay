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

  def complete 
    if session[:status] == 'succeeded'
      @message = Payment::Message::SUCCESS
      # create order and mark it PROCESSING
      # clear cart
    end 

    if session[:status] == 'awaiting_next_action'
      paymongo = Paymongo::V1::CardPayment.new 
      response = paymongo.retrieve_payment_intent(session[:payment_intent_id])

      if paymongo.payment_success?(response) 
        @message = Payment::Message::SUCCESS
        # create order and mark it PROCESSING
        # clear cart
      else 
        @message = Payment::Message::ERROR
      end
    end
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

  def credit_card_params
    params.require(:credit_card_payment_info).permit(
      :name, 
      :email, 
      :card_number, 
      :exp_month, 
      :exp_year, 
      :cvc
    )
  end
end
