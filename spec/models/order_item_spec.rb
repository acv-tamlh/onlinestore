require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validates' do
    it { should belong_to(:product) }
    it { should belong_to(:order) }

    context 'custom' do
      it 'product_present' do
        order_item = build(:order_item, product_id: 12)
        order_item.validate
        expect(order_item.errors.messages).to include(:product=>["must exist", "is not avalable"])
      end
      it 'order_present' do
        order_item = build(:order_item, order_id: 123)
        order_item.validate
        ms = ["must exist", "is not a valid order"]
        expect(order_item.errors.messages).to include(:order => ["must exist", "is not a valid order"])
      end
    end
  end
  describe 'Hook' do
    context 'before_save' do
      it 'finalize' do
        order_item = create(:order_item, order_id: order.id)
        expect(order_item.total_price).to eq order_item.quantity * order_item.unit_price
        order_item.save
      end
    end
  end
end
