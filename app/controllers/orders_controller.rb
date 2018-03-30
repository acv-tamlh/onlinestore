class OrdersController < ApplicationController
  before_action :get_order, only: [:show, :edit, :update]
  def show
    @order_items = current_order.order_items
    @limit_order_items = @order_items.page(params[:page]).per(1)
  end

  def edit
  end

  def update
    # byebug
    @order = Order.find(params[:id])
    order_params = params.require(:order).permit(:full_name, :email, :address, :phone)
    return redirect_to @order, notice: 'Update sucessfully qwdqwqwe' if @order.update(order_params)
    redirect_to @order, notice: 'Update fail'
  end

  private
    def get_order
      @order = Order.find(params[:id])
    end
end
