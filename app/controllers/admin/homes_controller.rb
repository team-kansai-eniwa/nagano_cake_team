class Admin::HomesController < ApplicationController
  # before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page])
    # @order_details = OrderDetail.includes(order: :customer).order(created_at: :desc).page(params[:page]).per(10)
  end
end
