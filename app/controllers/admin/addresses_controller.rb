class Admin::AddressesController < ApplicationController
  before_action :set_customer, except: %i[ index ]
  before_action :set_address, only: %i[ show edit update destroy ]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = @customer.addresses.build
  end

  def edit
  end

  def create
    @address = @customer.addresses.build(address_params)

    if @address.save
      redirect_to admin_customer_path(@customer), notice: "Address was successfully created."
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to admin_customer_path(@customer), notice: "Address was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to admin_customer_path(@customer), notice: "Address was successfully updated."
  end

  private

  def set_customer
    @customer = Customers::CustomerService.find(params[:customer_id])

    if @customer.nil?
      redirect_to admin_customer_path, notice: "Customer does not exist."
    end
  end

  def set_address
    @address = @customer.addresses.find_by(id: params[:id])

    if @address.nil?
      redirect_to admin_customer_path(@customer), notice: "Address was successfully updated."
    end
  end

  def address_params
    params.require(:address).permit(
      :house_number, 
      :street,
      :town,
      :city,
      :country,
      :zip_code,
      :mobile_number
    )
  end
end
