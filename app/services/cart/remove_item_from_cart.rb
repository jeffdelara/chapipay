module Cart 
  class RemoveItemFromCart
    def self.remove(user, id)
      cart_item = user.cart_items.find(id)
      cart_item.destroy
    end
  end
end
