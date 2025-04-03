class Public::AdressesController < ApplicationController
  def index
    @genres = Genre.only_active
    @adresses = current_customer.adresses
    @adress = Adress.new
  end

  def create
    @adresses = current_customer.adresses
    # @address = @addresses.new(address_params)
    # こう書くと、save出来なかった時に、@addressesの最後に空レコードが入り、エラーになる。
    @adress = Adress.new(adress_params)
    @adress.customer_id = current_customer.id
    @adress.save ? (redirect_to adresses_path) : (render :index)
  end
  
  def edit
    @adresses = current_customer.adresses
    @adress = @adresses.find_by(id: params[:id])
    redirect_to adresses_path unless @adress
  end

  def update
    @adress.update(adress_params) ? (redirect_to adresses_path) : (render :edit)
  end

  private


  def adress_params
    params.require(:adress).permit(:postal_code, :destination, :name)
  end
end
