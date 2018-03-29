class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
        # @order = Order.find(session[:order_id])
        # rescue ActiveRecord::RecordNotFound
        # @order = Order.create
        # session[:order_id] = @order.id

        # Order.find(session[:order_id])
        # rescue ActiveRecord::RecordNotFound
        # order = Order.create
        # session[:order_id] = order.id
        # order
  end
end
