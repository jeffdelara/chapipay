class Store::CardPaymentsController < ApplicationController

  def create
    amount = Cart::CartService.get_total(current_user)
    description = "#{current_user.email}: #{amount} #{Time.current}"
    
    response = Payment::PaymongoCreditCard.make_payment(
      credit_card_params, 
      amount, 
      description
    )

    status = response[:status]

    if status == 'awaiting_next_action'
      session[:status] = status
      session[:payment_intent_id] = response[:payment_intent_id]
      redirect_to response[:return_url]
    elsif status == 'succeeded'
      session[:status] = status
      redirect_to payments_complete_path
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
