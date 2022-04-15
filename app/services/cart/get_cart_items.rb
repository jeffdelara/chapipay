module Cart 
  class GetCartItems
    def self.get(customer)
      customer.cart_items
    end
  end
end
