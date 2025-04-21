class Public::ItemsController < ApplicationController

  def index
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = Item.genre_search(params[:genre_id]).page(params[:page]).per(8)
      @genres = Genre.all
      
    else
      @items = Item.page(params[:page]).per(8)
      @genres = Genre.all
      @items_all = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item_new = CartItem.new
  end

end
