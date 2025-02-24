class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.recommended
  end

  def about
  end
end
