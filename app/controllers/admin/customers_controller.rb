class Admin::CustomersController < ApplicationController
  # before_action :authenticate_admin!
  
  #order_detailsのデータが保存されていないため現在は表示されない
  def index
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end

  def show
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end

  def edit
  end

  def update
  end
end
