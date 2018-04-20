Productgroup.delete_all
Product.delete_all

ACCESS_KEY_ID = ENV["ACCESS_KEY_ID"]
SECRET_KEY = ENV["SECRET_KEY"]
ENDPOINT = "webservices.amazon.in"
ASSOCIATE_TAG = 'onlinestore'
status = ['Inprocess', 'Recieved']
status.each do |s|
  puts s
  OrderStatus.create(name: s)
end

Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ACCESS_KEY_ID
  options[:AWS_secret_key] = SECRET_KEY
  options[:associate_tag] = ASSOCIATE_TAG
end

productGroups = ['Book','DVD','Toys','VideoGames', 'ArtsAndCrafts']

productGroups.each do |productGroup|
  keywords = ['game', 'apple', 'phone', 'asus', 'friends']
  prg = Productgroup.create!(title: productGroup)
  keywords.each do |kw|
    res = Amazon::Ecs.item_search(kw, {
                                  :search_index => productGroup,
                                  :response_group => 'Medium',
                                  :sort => 'salesrank'
                                  })
    res.items.each do |item|
      item_attributes = item.get_element('ItemAttributes')
      asin = item.get('ASIN')
      title = item.get('ItemAttributes/Title')
      artist = item.get('ItemAttributes/Artist')
      image = item.get('LargeImage/URL')
      #price
      price = item_attributes.get("ListPrice/Amount")
      currency = item_attributes.get("ListPrice/CurrencyCode")
      formattedprice = item_attributes.get("ListPrice/FormattedPrice")
      #url to amazon
      refurl = item.get('DetailPageURL')
      puts res.error                                 # error message
      puts asin
      p = Product.create(asin: asin, title: title, artist: artist, price: price, currency: currency, formattedprice: formattedprice, productgroup_id: prg.id, image: image, refurl: refurl)#, review: review)
    end
  end

end
