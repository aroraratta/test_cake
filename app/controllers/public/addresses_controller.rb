class Public::AddressesController < ApplicationController
  def index
    @genres = Genre.only_active
    @addresses = current_customer.addresses
    @adress = Address.new
  end

  def create
    @addresses = current_customer.addresses
    # @address = @addresses.new(address_params)
    # こう書くと、save出来なかった時に、@addressesの最後に空レコードが入り、エラーになる。
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save ? (redirect_to adrdesses_path) : (render :index)
  end
  
  def edit
    @addresses = current_customer.addresses
    @address = @addresses.find_by(id: params[:id])
    redirect_to addresses_path unless @address
  end

  def update
    @address.update(address_params) ? (redirect_to addresses_path) : (render :edit)
  end

  private


  def address_params
    params.require(:address).permit(:postal_code, :destination, :name)
  end
end
