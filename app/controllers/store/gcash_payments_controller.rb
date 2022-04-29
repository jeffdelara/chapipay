class Store::GcashPaymentsController < ApplicationController

  def create
    amount = Cart::CartService.get_total(current_user)

    begin
      response = Payment::PaymongoGcash.make_source(amount)

      src_status = response[:status]
      src_id = response[:id]
      session[:status] = src_status
      session[:gcash_src_id] = src_id

      session[:address_id] = params[:address_id]

      if src_status == 'pending'
        redirect_to response[:checkout_url]
      end

    end
  end

  def success
    response_src = Payment::PaymongoGcash.get_source(session[:gcash_src_id])
    retrieve_src_amount = response_src[:amount]

    response_pay = Payment::PaymongoGcash.make_payment(retrieve_src_amount, session[:gcash_src_id])
    transaction_id = response_pay[:id]

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
  end

  def failed
    redirect_to root_path, alert: 'Payment failed! Please try again.'
  end
end
