class Admin::PendingOrdersController < ApplicationController
  def index
    @pending_orders = Order.includes(:user).where(status: 'pending')
  end
end
