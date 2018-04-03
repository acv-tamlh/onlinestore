FactoryBot.define do
  factory :order do
    tax 00
    shipping 11
    total 11
    # order_status_id { create(:order_status).id }
    user_id { create(:user).id }
    token_payment "token_payment"
    payer_id "payer_id"
    payment_id "paument_id"
  end
end
