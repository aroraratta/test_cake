class Public::AddressesController < ApplicationController
  def index
    @genres = Genre.only_active
    @addresses = current_customer.addresses
    @address = Address.new
  end
end
