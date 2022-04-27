class Customer::DashboardController < ApplicationController
  def index
    @order = current_user.orders.last
  end
end
