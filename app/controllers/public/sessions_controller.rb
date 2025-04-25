# frozen_string_literal: true
class Public::SessionsController < Devise::SessionsController
  before_action :reject_end_customer, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  


  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def reject_end_customer
    email = params[:customer][:email]
    password = params[:customer][:password]
    @end_user = Customer.find_by(email: email)
  
    if @end_user && @end_user.valid_password?(password) && @end_user.is_active == false
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      Rails.logger.debug "[DEBUG] flash.now[:notice] = #{flash.now[:notice]}"
      self.resource = Customer.new
      @resource = resource
      @resource_name = :customer
      redirect_to root_path
    end
  end

  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
