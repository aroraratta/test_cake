class Public::ItemsController < ApplicationController
  def index
    all_items = Item.where_genre_active.order(created_at: :desc)
    @items = all_items.page(params[:page]).per(8)
    @all_items_count = all_items.count
    @genres = Genre.only_active
  end

  def show
    @genres = Genre.only_active
    @item = Item.where_genre_active.find(params[:id])
  end
end
