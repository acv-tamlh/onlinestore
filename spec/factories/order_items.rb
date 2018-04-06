FactoryBot.define do
  factory :order_item do
    product_id { create(:product).id }
    order_id { create(:order).id }
    unit_price 123
    quantity 345
  end
end
