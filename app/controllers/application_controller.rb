class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :phone, :address])
  end
  def current_order
    Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
    order = Order.create(order_status: 'In Process')
    session[:order_id] = order.id
    order
  end
end
