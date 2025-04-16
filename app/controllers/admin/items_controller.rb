class Admin::ItemsController < ApplicationController
  # before_action :authenticate_admin!
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      redirect_to admin_items_path, notice: '商品が登録されました。'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :image, :is_active)
  end
end
