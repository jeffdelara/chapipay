class Admin::PendingOrdersController < ApplicationController
  def index
    @pending_orders = Order.includes(:user).where(status: 'Pending')
  end
end
