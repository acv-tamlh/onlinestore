class ProductsController < ApplicationController
  before_action :get_product, only: [:show]

  def index
    @products = Product.all.page(params[:page]).per(10)
    @order_item = current_order.order_items.new
  end

  def show
    @order_item = current_order.order_items.new
    ResetPasswordMailer.welcome_email(current_user).deliver_later
  end

  private
    def get_product
      @product = Product.find(params[:id])
    end
end
