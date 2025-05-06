class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    @cart_items = current_customer.cart_items.includes(:item)
    @order = Order.new(order_params)
    if params[:select_address] == '0'
      @order.get_shipping_informations_from(current_customer)
    elsif params[:select_address] == '1'
      @selected_address = current_customer.addresses.find(params[:address_id])
      @order.get_shipping_informations_from(@selected_address)
    elsif params[:select_address] == '2' && (@order.postal_code =~ /\A\d{7}\z/) && @order.destination? && @order.name?
      # 処理なし
    else
      flash[:error] = '情報を正しく入力して下さい。'
      render :new
    end
  end
  
  def create
    @cart_items = current_customer.cart_items.includes(:item)
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.grand_total = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @order.create_order_details(current_customer)
      redirect_to public_order_path
    else
      render :new
    end
  end
  
  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end
  
  def thanks
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
  
  private

  def order_params
    params.require(:order).permit(:postal_code, :destination, :name, :payment_method)
  end
end
