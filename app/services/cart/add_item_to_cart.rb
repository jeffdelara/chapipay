module Cart 
  class AddItemToCart
    def self.add(customer, product_id)
      cart_item = customer.cart_items.where(
        :product_id => product_id
      ).first_or_create
    
      cart_item.quantity += 1

      if cart_item.save 
        return cart_item 
      else 
        return false
      end
    end
  end
end
