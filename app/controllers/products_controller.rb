class ProductsController < ApplicationController
  before_action :get_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  private
    def get_product
      @product = Product.find(params[:id])
    end
end
