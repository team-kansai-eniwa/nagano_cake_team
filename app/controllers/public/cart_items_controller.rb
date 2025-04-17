class Public::CartItemsController < ApplicationController
  #before_action :authenticate_customer!
  
  def index
    @cart_item = CartItem.new
    @cart_items = CartItem.all
    @unit_price = @cart_items.item.price
    @total_price = 0
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end
end
