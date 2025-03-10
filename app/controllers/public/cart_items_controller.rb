class Public::CartItemsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @cart_item = current_customer.has_in_cart(@item)
    if @cart_item
      new_amount = @cart_item.amount + cart_item_params[:amount]
      @cart_item.update(amount: new_amount)
      redirect_to public_cart_items_path
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.item_id = @item.id
      if @cart_item.save
        redirect_to public_cart_items_path
      else
        render 'public/items/show'
      end
    end
  end
  
  def update
    if @cart_item
      @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    end
  end

  def index
    @genres = Genre.only_active
    @cart_items = current_customer.cart_items.includes(:item)
  end

  private
  
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
