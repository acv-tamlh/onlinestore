class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @histories = current_user.orders.page(params[:page])
  end
  def show
    # binding.pry
    @order = current_user.orders.find(params[:id])
    @history = @order.order_items.page(params[:page])
  end
end
