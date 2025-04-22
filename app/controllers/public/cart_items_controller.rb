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
  @cart_item = CartItem.new(cart_item_params)

  if @cart_item.amount.to_i <= 0
    return redirect_back fallback_location: item_path(@cart_item.item_id)
  end

  overlap_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
  if overlap_item
    overlap_item.amount += @cart_item.amount.to_i
    overlap_item.save
  else
    @cart_item.save
  end
  redirect_to cart_items_path
end

private


  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
