class Public::CustomersController < ApplicationController
  def show
    @genres = Genre.only_active
    @customer = current_customer
  end

end
