module Orders 
  class CreateOrder
    def self.run(user_id, address_id, transaction_id, status='processing')
      address = Address.find(address_id)
      user = Customers::CustomerService.find(user_id)
      cart = Cart::CartService.get(user)

      delivery_details = "#{address.house_number} #{address.street}, 
        #{address.town}, #{address.city}, #{address.state}, 
        #{address.country} #{address.zip_code} 
        #{address.mobile_number}"

      customer_details = "#{user.first_name} #{user.last_name} #{user.email}"

      cart_details = ""
      total = 0.0

      cart.each do |item|
        cart_details += "#{item.product.name} x #{item.quantity}"
        total += item.product.price * item.quantity
      end
      
      Order.create(
        customer_details: customer_details, 
        delivery_details: delivery_details, 
        status: status,
        total: total, 
        user: user, 
        transaction_id: transaction_id
      )

      # Save this to connect paymongo transaction id with order
      # response['data']['attributes']['payments'].first['id']
    end
  end
end
