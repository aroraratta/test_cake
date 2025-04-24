class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @cart_items = current_customer.cart_items.includes(:item)
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.grand_total = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @order.create_order_details(current_customer)
      redirect_to thanks_path
    else
      render :new
    end
  end
  
  private

  def order_params
    params.require(:order).permit(:postal_code, :destination, :name, :payment_method)
  end
end
