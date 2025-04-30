class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all

  
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = Item.on_sale.genre_search(params[:genre_id]).page(params[:page]).per(8)
      
    else
      @items = Item.on_sale.page(params[:page]).per(8)
      @items_count = Item.on_sale.count
      @genre = Genre.all
    end
  end

  def show
    @item = Item.find(params[:id])

    if !@item.is_active #商品がアクティブではない場合
      redirect_to items_path, alert: "この商品は現在販売停止中です。"
      return
    end
    
    @genres = Genre.all
    @cart_item_new = CartItem.new
  end
end
