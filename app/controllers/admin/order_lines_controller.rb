class Admin::OrderLinesController < ApplicationController

  before_action :require_admin
  before_action :get_order
  before_action :get_order_line, only: [:show, :edit, :update, :destroy]

  def index
    @order_id = params[:order_id]
  end

  def show
  end

  def new
    @order_line = @order.order_lines.build
  end

  def create
    @order_line = @order.order_lines.build(order_line_params)

    if @order_line.save
      redirect_to admin_order_order_lines_path(@order_line), notice: 'Order line was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order_line.update(order_line_params)
      redirect_to admin_order_order_lines_path(@order_line), notice: 'Order line was successfully updated.'
    else
      render: edit
    end
  end

  def destroy
    @order_line.destroy
    redirect_to admin_order_order_lines_path(@order_line), notice: 'Order line was successfully destroyed.'
  end

  private

  def get_order
    @order = Orders.find(params[:order_id])
  end

  def get_order_line
    @order_line = @order.order_line.find(params[:id])
  end

  def order_line_params
    params.require(:order_line).permit(:order_id, :user_id, :product_name, :price, :quantity, :subtotal, :sku)
  end
end
