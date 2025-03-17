class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
  end
end
