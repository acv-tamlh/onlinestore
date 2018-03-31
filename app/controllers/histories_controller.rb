class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @histories = current_user.orders.page(params[:page]).per(10)
  end
  def show
    @history = current_user.orders.find(params[:id]).order_items.page(params[:page]).per(4)
  end
end
