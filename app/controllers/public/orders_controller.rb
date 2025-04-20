class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  attr_accessor :total_price
  
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.includes(:item)
    @total_price = 0
    @postage = 800
    @order = Order.new

    @cart_items.each do |cart_item|
      @total_price += cart_item.subtotal
    end

    session[:cart_item] = @cart_items
    session[:total_price] = @total_price + @postage
    
    if params[:order][:select_address].present? && params[:order][:payment_method].present?
      if params[:order][:select_address] == "self"
        Rails.logger.debug "params[:order] = #{params[:order].inspect}"
        @num = 1
        Rails.logger.debug(params[:order])
        @order = Order.new(order_params)
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        

        session[:payment_method] = @order.payment_method
        session[:postal_code] = current_customer.postal_code
        session[:address] = current_customer.address
        session[:name] = current_customer.last_name + current_customer.first_name

      elsif params[:order][:select_address] == "registered"
        @order = Order.new(order_params)
        select_address = current_customer.addresses.find(params[:order][:address_id])
        @order.postal_code = select_address.postal_code
        @order.address = select_address.address
        @order.name = select_address.name

        session[:payment_method] = @order.payment_method
        session[:postal_code] = @order.postal_code
        session[:address] = @order.address
        session[:name] = @order.name

      elsif params[:order][:select_address] == "new"
        @order = Order.new(order_params)

        session[:payment_method] = @order.payment_method
        session[:postal_code] = @order.postal_code
        session[:address] = @order.address
        session[:name] = @order.name
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
    @order = Order.new
    @order.shipping_cost = 800
    @order.customer_id = current_customer.id

    @order.payment_method = session[:payment_method]
    @order.postal_code = session[:postal_code]
    @order.name = session[:name]
    @order.address = session[:address]
    @order.total_payment = session[:total_price]

    if @order.save
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def index
    @orders = current_customer.orders.includes(order_details: :item)
  end

  def show
    @postage = 800
    @order = current_customer.orders.find(params[:id])
    @order_details = current_customer.orders.includes(order_details: :item)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
