require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do

  describe "GET #update" do
    let!(:order_item) { create(:order_item, quantity: 100) }
    # it "returns http success" do
    #   old_quantity = order_item.quantity
    #   put :update, params: {order_item: FactoryBot.attributes_for(:order_item, quantity: 1)  }
    #   order_item.reload
    #   new_quantity = order_item.quantity
    #   expect(old_quantity).to eq new_quantity
    # end
  end
end
