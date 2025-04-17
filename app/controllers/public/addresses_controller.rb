class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @address = current_customer.address
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
