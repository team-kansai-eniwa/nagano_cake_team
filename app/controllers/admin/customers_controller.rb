class Admin::CustomersController < ApplicationController
  # before_action :authenticate_admin!
  
  #order_detailsのデータが保存されていないため現在は表示されない
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  end
end
