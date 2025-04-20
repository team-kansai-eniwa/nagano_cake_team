class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  # order_detailsのデータが保存されていないため現在は表示されない
  def top
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end
end
