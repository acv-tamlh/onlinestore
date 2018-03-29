class ProductgroupsController < ApplicationController
  before_action :get_productgroup, only: [:show]
  before_action :params_productgroup, only: [:create, :update]
  def index
    @productgroups = Productgroup.all.page(params[:page]).per(10)
  end

  def show
    @limitproducts = @productgroup.products.page(params[:page]).per(5)
    @order_item = current_order.order_items.new
  end

  def new
    @productgroup = Productgroup.new
  end

  def create
    @productgroup = Productgroup.new(params_productgroup)
    return redirect_to productgroup_path(@productgroup), notice: 'Create sucessfully' if @productgroup.save
    return render :new, alert: 'Create fail'
  end
  private
    def get_productgroup
      @productgroup = Productgroup.find(params[:id])
    end

    def params_productgroup
      params_productgroup = params.require(:productgroup).permit(:title, :description)
    end
end
