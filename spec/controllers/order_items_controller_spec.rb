require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:product) { create(:product) }
  def current_order
    Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
    order = Order.create(order_status: 'In Process')
    session[:order_id] = order.id
    order
  end
  describe 'POST #create' do

    def do_request
      # binding.pry
      post :create, :format => 'js', params: {order_item: FactoryBot.attributes_for(:order_item) }
    end
    it 'sucessfully' do
      expect{ do_request }.to change(OrderItem, :count).by(1)
    end
  end
  describe "PATCH #update" do
    let!(:order_item) { create(:order_item, order_id: current_order.id) }
    def update(quantity)
      patch :update, params: { id: order_item.id, order_item: { quantity: quantity } }
    end
    it "success" do
      old_quantity = order_item.quantity
      quantity = 123123
      update(quantity)
      order_item.reload
      new_quantity = order_item.quantity
      expect(old_quantity).not_to eq new_quantity
      expect(new_quantity).to eq quantity
    end
  end
  describe "DELETE #destroy" do
    let!(:order_item) { create(:order_item, order_id: current_order.id) }
    def destroy
      delete :destroy, params: {id: order_item.id}
    end
    it 'sucessfully' do
      expect{ destroy }.to change(OrderItem, :count).by(-1)
    end
  end
end
