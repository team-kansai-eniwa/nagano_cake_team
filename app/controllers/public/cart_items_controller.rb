class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to request.referer
    else
      render :index
    end
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])

    if @cart_item.destroy
      redirect_to request.referer
    else
      render :index
    end
  end

  def destroy_all
    if current_customer.cart_items.destroy_all
      redirect_to request.referer
    else
      render :index
    end
  end

  def create
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
