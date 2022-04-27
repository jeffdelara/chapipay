module ApplicationHelper

  def compute_cart_total(cart_items)
    cart_items.reduce(0) { |acc, item| acc + (item.quantity * item.product.price) }
  end

  def cart_count 
    cart = current_user.cart_items.count
  end

  def human_date(date)
    date.in_time_zone("Asia/Singapore").strftime("%b %d, %Y %l:%M %p")
  end

end
