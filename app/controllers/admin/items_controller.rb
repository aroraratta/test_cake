class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render new
    end
  end

  def index
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :item_image, :price, :is_active)
  end

end
