class Admin::OrdersController < ApplicationController
  # before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end

  def customer_index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.order(created_at: :desc).page(params[:page]) 
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
  end
  
end
