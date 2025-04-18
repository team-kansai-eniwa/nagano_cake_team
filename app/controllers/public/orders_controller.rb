class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.includes(:item)
    @total_price = 0
    @postage = 800
    @order = Order.new
    
    if params[:order][:select_address].present? && params[:order][:payment_method].present?
      if params[:order][:select_address] == "self"
        @num = 1
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address

      elsif params[:order][:select_address] == "registered"
        @num = 2
        select_address = current_customer.addresses.find(params[:order][:address_id])
        @order.postal_code = select_address.postal_code
        @order.address = select_address.address
        @order.name = select_address.name

      elsif params[:order][:select_address] == "new"
        @num = 3
        @order = Order.new(new_address_params)
      end

    elsif params[:order][:select_address].present? && params[:order][:payment_method].nil?
      flash[:alert] = "支払先を選択してください"
        @order = Order.new
        render :new

    elsif params[:order][:select_address].nil? && params[:order][:payment_method].present?
      flash[:alert] = "お届け先を選択してください"
        @order = Order.new
        render :new
    elsif params[:order][:select_address].nil? && params[:order][:payment_method].nil?
      flash[:alert] = "支払先及びお届け先を選択してください"
        @order = Order.new
        render :new
    end
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:select_address, :address_id, :payment_method, :postal_code, :address, :name)
  end

  def new_address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
