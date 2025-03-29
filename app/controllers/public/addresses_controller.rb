class Public::AddressesController < ApplicationController
  def index
    @genres = Genre.only_active
    @addresses = current_customer.addresses
    @address = Address.new
  end
  private


  def address_params
    params.require(:adress).permit(:postal_code, :destination, :name)
  end
end
