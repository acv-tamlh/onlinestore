require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Association' do
    it { should have_many(:order_items) }
    it { should belong_to(:user) }
  end
  describe 'Hook' do
    context 'before_create' do
      let!(:order) { build(:order) }
      it 'set_order_status' do
        expect(order.order_status).not_to eq 'In Process'
        order.save
        expect(order.order_status).to eq 'In Process'
      end
    end
    context 'before_create' do
      it 'update_subtotal' do
        order = create(:order)
        old_subtotal = order.subtotal
        oi = create(:order_item, order_id: order.id)
        oi2 = create(:order_item, order_id: order.id)
        order.reload
        new_subtotal = order.subtotal
        expect(old_subtotal).not_to eq new_subtotal
      end
    end
  end
end
