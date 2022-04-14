module ApplicationHelper

  def compute_cart_total(cart_items)
    cart_items.reduce(0) { |acc, item| acc + (item.quantity * item.product.price) }
  end

  def cart_count 
    cart = current_user.cart_items.count
  end

end
