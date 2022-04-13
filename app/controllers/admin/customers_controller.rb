class Admin::CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index 
    @customers = Customers::CustomerService.all
  end

  def show
  end

  def new 
    @customer = Customer.new
  end

  def create 
    @customer = Customer.new(customer_params) 
    
    if @customer.save
      redirect_to admin_customers_path, notice: 'Customer added.'
    else 
      render :new
    end
  end

  def edit 
  end

  def update 
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: 'Customer updated.'
    else 
      render :edit
    end
  end

  def destroy 
    @customer.destroy 
    redirect_to admin_customers_path, notice: 'Customer successfully deleted.'
  end
  

  private 

  def set_customer 
    @customer = Customers::CustomerService.find(params[:id])
  end
  
  def customer_params 
    params.require(:customer).permit(
      :first_name, 
      :last_name,
      :email, 
      :password
    )
  end

end
