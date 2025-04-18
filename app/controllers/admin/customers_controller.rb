class Admin::CustomersController < ApplicationController
  # before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end
end
