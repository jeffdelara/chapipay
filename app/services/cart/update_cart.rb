module Cart 
  class UpdateCart
    def self.update(id:, quantity:, customer:)
      cart_item = customer.cart_items.find_by(:id => id)
      cart_item.quantity = quantity
      
      if cart_item.save 
        return cart_item
      else 
        return false
      end
    end
  end
end
