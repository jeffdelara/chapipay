class Store::CardPaymentsController < ApplicationController

  def create
    amount = Cart::CartService.get_total(current_user)
    description = "#{current_user.email}: #{amount} #{Time.current}"
    session[:address_id] = credit_card_params[:address_id]

    begin 
    response = Payment::PaymongoCreditCard.make_payment(
      credit_card_params, 
      amount, 
      description
    )

    status = response[:status]
    session[:payment_intent_id] = response[:payment_intent_id]

    if status == 'awaiting_next_action'
      session[:status] = status
      redirect_to response[:return_url]
    elsif status == 'succeeded'
      session[:status] = status
      redirect_to card_payments_complete_path
    end

    rescue ApiExceptions::BadRequest, StandardError
      redirect_to payments_url('address[id]': session[:address_id]), alert: 'Credit card failed.'
    end
  end

  def complete 
    paymongo = Paymongo::V1::CardPayment.new
    response = paymongo.retrieve_payment_intent(
      session[:payment_intent_id]
    )
    status = response['data']['attributes']['status']
    byebug
    if status == 'succeeded'
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

    elsif status == 'awaiting_next_action'      
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

    else  
      @message = Payment::Message::ERROR
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
