class ProductgroupsController < ApplicationController
  before_action :get_productgroup, only: [:show]
  def index
    @productgroups = Productgroup.all
  end

  def show
  end

  private
    def get_productgroup
      @productgroup = Productgroup.find(params[:id])
    end
end
