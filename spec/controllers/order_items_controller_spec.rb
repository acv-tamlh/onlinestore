require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:product) { create(:product) }
  describe "GET #update" do
    # let!(:order_item) { create(:order_item) }
    def params(quantity = 123)
      order_item_params = { quantity: quantity }
    end
    it "returns http success" do
      user = User.create!(email: 'asdasdasdasdasd@email.com', password: '123213123')
      order = Order.create!(user_id: user.id)
      order_item = OrderItem.create(order_id: order.id, product_id: product.id, quantity: 12)
      binding.pry
      patch :update, params: {id: order_item.id, order_item: {quantity: 123}  }
      order_item.reload
      new_quantity = order_item.quantity
      expect(old_quantity).to eq new_quantity
    end
  end
end
