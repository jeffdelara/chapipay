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
    session[:address_id] = credit_card_params[:address_id]
    session[:payment_intent_id] = response[:payment_intent_id]

    if status == 'awaiting_next_action'
      session[:status] = status
      redirect_to response[:return_url]
    elsif status == 'succeeded'
      session[:status] = status
      redirect_to card_payments_complete_path
    end
  end

  def complete 
    paymongo = Paymongo::V1::CardPayment.new

    if session[:status] == 'succeeded'
      response = paymongo.retrieve_payment_intent(
        session[:payment_intent_id]
      )

      transaction_id = response['data']['attributes']['payments'].first['id']

      unless Order.find_by(transaction_id: transaction_id)
        order = Orders::CreateOrder.run(
          current_user.id, 
          session[:address_id], 
          transaction_id, 
          'paid'
        )

        # clear cart
        Cart::CartService.remove_all(current_user)
        redirect_to customer_order_path(order), notice: 'Payment successful!'
      end

    elsif session[:status] == 'awaiting_next_action'
      response = paymongo.retrieve_payment_intent(
        session[:payment_intent_id]
      )
      
      transaction_id = response['data']['attributes']['payments'].first['id']

      if paymongo.payment_success?(response) 
        
        unless Order.find_by(transaction_id: transaction_id)
          order = Orders::CreateOrder.run(
            current_user.id, 
            session[:address_id],
            transaction_id,
            'paid'
          )
          
          # clear cart
          Cart::CartService.remove_all(current_user)
          redirect_to customer_order_path(order), notice: 'Payment successful!'
        end

      else 
        # fail payment
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
      :cvc, 
      :address_id
    )
  end

end
