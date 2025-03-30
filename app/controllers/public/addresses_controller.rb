class Public::AddressesController < ApplicationController
  def index
    @genres = Genre.only_active
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @addresses = current_customer.addresses
    # @address = @addresses.new(address_params)
    # こう書くと、save出来なかった時に、@addressesの最後に空レコードが入り、エラーになる。
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save ? (redirect_to addresses_path) : (render :index)
  end

  private


  def address_params
    params.require(:adress).permit(:postal_code, :destination, :name)
  end
end
