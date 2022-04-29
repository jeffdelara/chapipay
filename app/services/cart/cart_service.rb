module Cart 
  class CartService 

    def self.add(customer, product_id)
      return false unless Product.find_by(id: product_id)&.in_stock?

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

    def self.get(customer)
      customer.cart_items
    end

    def self.get_total(customer)
      cart_items = customer.cart_items
      return 0 if cart_items.count == 0
      
      total = cart_items.reduce(0) do |acc, item|
        acc + (item.product.price * item.quantity)
      end

      total
    end

    def self.remove(user, id)
      cart_item = user.cart_items.find(id)
      cart_item.destroy
    end

    def self.remove_all(user)
      user.cart_items.destroy_all
    end

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
