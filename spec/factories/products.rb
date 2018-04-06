FactoryBot.define do
  factory :product do
    asin  "B000I187C4"
    title  "Your Shoes Untied/Squid's Day Off"
    productgroup_id { create(:productgroup).id }
    image  "https://images-na.ssl-images-amazon.com/images/I/51cTL5m6rOL.jpg"
    refurl  "https://www.amazon.com/Your-Shoes-Untied-Squids-Day/dp/B000I187C4?SubscriptionId=AKIAJWPWTVNYFLW7EKHQ&amp;tag=onlinestore&amp;linkCode=xm2&amp;camp=2025&amp;creative=165953&amp;creativeASIN=B000I187C4"
    price  199.0
    currency  "USD"
    formattedprice  "$1.99"
  end
end
