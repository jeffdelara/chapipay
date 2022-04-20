class Store::PaymentsController < ApplicationController
  def index
    @address = current_user.addresses.find(params[:address_id])
    @cart_items = Cart::CartService.get(current_user)
  end

  def show
  end

  def create
    amount = Cart::CartService.get_total(current_user)
    description = "#{current_user.email}: #{amount} #{Time.current}"
    
    response = Payment::PaymongoCreditCard.make_payment(
      credit_card_params, 
      amount, 
      description
    )

    status = response['data']['attributes']['status']

    if status == 'awaiting_next_action'
      session[:status] = status
      session[:payment_intent_id] = response['data']['id']
      return_url = response['data']['attributes']['next_action']['redirect']['url']
      redirect_to return_url
    elsif status == 'succeeded'
      session[:status] = status
      redirect_to payments_complete_path
    end
  end

  def complete 
    if session[:status] == 'succeeded'
      @message = Payment::Message::SUCCESS
    end 

    if session[:status] == 'awaiting_next_action'
      paymongo = Paymongo::V1::CardPayment.new 
      response = paymongo.retrieve_payment_intent(session[:payment_intent_id])

      if paymongo.payment_success?(response) 
        @message = Payment::Message::SUCCESS
      else 
        @message = Payment::Message::ERROR
      end
    end
  end

  private

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
