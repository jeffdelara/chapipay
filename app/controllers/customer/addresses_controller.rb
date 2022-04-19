class Customer::AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]

  def index
    @addresses = current_user.addresses
  end

  def show; end

  def new
    @address = current_user.addresses.build
  end

  def edit; end

  def create
    @address = current_user.addresses.build(address_params)

    if @address.save
      redirect_to customer_addresses_path, notice: "Address was successfully created"
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to customer_addresses_path, notice: "Address was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to customer_addresses_path, notice: "Address was successfully deleted"
  end

  private

  def set_address
    @address = current_user.addresses.find_by(id: params[:id])

    if @address.nil?
      redirect_to customer_addresses_path, notice: "No address found"
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
      :mobile_number,
      :state
    )
  end
end
