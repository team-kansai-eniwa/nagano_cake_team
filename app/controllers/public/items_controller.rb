class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
  
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = Item.genre_search(params[:genre_id]).page(params[:page]).per(8) 
      
    else
      @items = Item.page(params[:page]).per(8)
      @items_count = Item.all.count
      @genre = Genre.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item_new = CartItem.new
  end

end
