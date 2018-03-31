class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @histories = current_user.orders
  end
  def show
    @history = current_user.orders.find(params[:id])
  end
end
