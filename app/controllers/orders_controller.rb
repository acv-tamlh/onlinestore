class OrdersController < ApplicationController
  before_action :get_order, only: [:show, :edit, :update]
  def show
    @order_items = current_order.order_items
    @limit_order_items = @order_items.page(params[:page]).per(1)
  end

  private
    def get_order
      @order = Order.find(params[:id])
    end
end
