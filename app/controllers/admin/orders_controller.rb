class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
  end

  def customer_index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.order(created_at: :desc).page(params[:page]) 
  end

  def show
    @order = Order.find(params[:id])
    
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
