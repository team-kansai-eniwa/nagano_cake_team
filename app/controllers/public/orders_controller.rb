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
        
        if params[:order][:address_id].blank?
          flash[:alert] = "住所を選択してください"
          @order = Order.new
          render :new
        else
          select_address = current_customer.addresses.find(params[:order][:address_id])
          @order.postal_code = select_address.postal_code
          @order.address = select_address.address
          @order.name = select_address.name

          session[:payment_method] = @order.payment_method
          session[:postal_code] = @order.postal_code
          session[:address] = @order.address
          session[:name] = @order.name
        end

      elsif params[:order][:select_address] == "new"
        @order = Order.new(order_params)

        if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
          flash[:alert] = "入力フォームに不備があります"
          @order = Order.new
          render :new
        else
          session[:payment_method] = @order.payment_method
          session[:postal_code] = @order.postal_code
          session[:address] = @order.address
          session[:name] = @order.name
        end
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
      @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.price * 1.1
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end

      current_customer.cart_items.destroy_all

      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @postage = 800
    @total_price = 0
    @order = current_customer.orders.find(params[:id])
    
    @order.order_details.each do |order_detail|
      @total_price += order_detail.price * order_detail.amount
    end

    
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
