class ProductsController < ApplicationController
  before_action :get_product, only: [:show]

  def index
    @products = Product.all.page(params[:page])
    @order_item = current_order.order_items.new
  end

  def show
    @order_item = current_order.order_items.new
  end

  private
    def get_product
      @product = Product.find(params[:id])
    end
end
