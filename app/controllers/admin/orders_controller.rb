class Admin::OrdersController < ApplicationController

  before_action :require_admin
  before_action :set_customer, except: [:index]
  before_action :set_order, only: [:show, :edit, :update, :destroy] 

  # GET /admin/orders
  def index
    @orders = Order.all
  end

  # GET /admin/customers/1/orders/1
  def show
    @order_lines = @order.order_lines
  end

  # GET /admin/customers/1/orders/new
  def new
    # @order = Order.new
    @order = @customer.orders.build
  end

  # GET /admin/customers/1/orders/1/edit
  def edit
  end

  # POST /admin/customers/1/orders
  def create
    # @order = Order.new(order_params)
    @order = @customer.orders.build(order_params)
    if @order.save
      redirect_to admin_customer_path(@customer), notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PUT /admin/customers/1/orders/1
  def update
    if @order.update(order_params)
      redirect_to admin_customer_path(@customer), notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/customers/1/orders/1
  def destroy
    @order.destroy
    redirect_to admin_customer_path(@customer), notice: 'Order was successfully destroyed.'
  end

  private
    def set_customer
      @customer = Customers::CustomerService.find(params[:customer_id])

      if @customer.nil?
        redirect_to admin_customer_path, notice: "Customer does not exist."
      end
    end

    def set_order
      # @order = Order.find(params[:id])
      @order = @customer.orders.find_by(id:params[:id])
    end

    def order_params
      params.require(:order).permit(
        :customer_details,
        :delivery_details,
        :total,
        :status
      )
    end
end
