class Admin::OrderLinesController < ApplicationController

  before_action :require_admin
  before_action :set_customer, except: [:index]
  before_action :get_order, only: [:show, :edit, :update, :destroy]
  before_action :get_order_line, only: [:show, :edit, :update, :destroy]

  # GET /admin/customers/1/orders/1/order_lines
  def index
    @order_lines = OrderLine.all
  end

  # GET /admin/customers/1/orders/1/order_lines/1
  def show
   
  end

  # GET /admin/customers/1/orders/1/order_lines/new
  def new
    @order_line = @customer.order_lines.build
  end

  # POST /admin/customers/1/orders/1/order_lines
  def create
    @order_line = @customer.order_lines.build(order_line_params)
    @order_line.user_id = params[:customer_id]
    @order_line.order_id = params[:order_id]
    
    if @order_line.save
      redirect_to admin_customer_path(@customer), notice: 'Order line was successfully created.'
    else
      render :new
    end
  end

  # GET /admin/customers/1/orders/1/order_lines/1/edit
  def edit
  end

  # PUT /admin/customers/1/orders/1/order_lines/1
  def update
    if @order_line.update(order_line_params)
      redirect_to admin_customer_path(@customer), notice: 'Order line was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/customers/1/orders/1/order_lines/1
  def destroy
    @order_line.destroy
    redirect_to admin_customer_path(@customer), notice: 'Order line was successfully destroyed.'
  end

  private

  def set_customer
    @customer = Customers::CustomerService.find(params[:customer_id])

    if @customer.nil?
      redirect_to admin_customer_path, notice: "Customer does not exist."
    end
  end

  def get_order
    @order = @customer.orders.find_by(id: params[:order_id])
  end

  def get_order_line
    @order_line = @customer.order_lines.find_by(id: params[:id])
  end

  def order_line_params
    params.require(:order_line).permit(
      :order_id,
      :user_id,
      :product_name,
      :price,
      :quantity,
      :subtotal,
      :sku
    )
  end
end
