Productgroup.delete_all
Product.delete_all
OrderStatus.delete_all

status = ['Inprocess', 'Recieved']
status.each do |s|
  puts s
  OrderStatus.create(name: s)
end

  ACCESS_KEY_ID = ENV["ACCESS_KEY_ID"]
  SECRET_KEY = ENV["SECRET_KEY"]
  ENDPOINT = "webservices.amazon.in"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  require 'amazon/ecs'

  ACCESS_KEY_ID = "AKIAIXMVTFBCJZVBBALQ"

  # Your Secret Key corresponding to the above ID, as taken from the Your Account page
  SECRET_KEY = "MB7Y8Qj3BWub4o10f1VbiTH2t+1tiknBufRMfC8g"

  # The region you are interested in
  ENDPOINT = "webservices.amazon.in"

  REQUEST_URI = "/onca/xml"
  ASSOCIATE_TAG = 'onlinestore'


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
    # To replace default options
    # Amazon::Ecs.options = { ... }

    # To override default options
    res = Amazon::Ecs.item_search('ruby', {:search_index => 'VideoGames', :response_group => 'Small', :sort => 'salesrank', :country => 'in'})

    res.is_valid_request?
    res.has_error?
    res.error                                 # error message
    res.total_pages
    res.total_results
    res.item_page                             # current page no if :item_page option is provided

    # Find elements matching 'Item' in response object
    res.items.each do |item|
      # Retrieve string value using XML path
      asin = item.get('ASIN')
      title = item.get('ItemAttributes/Title')
      artist = item.get('ItemAttributes/Artist')
      # puts item.get('ItemAttributes/ProductGroup')
      puts '======='
      # puts item.get('ItemAttributes/Manufacturer')
      # puts item.get('ItemAttributes/Creator')

      # Return Amazon::Element instance
      item_attributes = item.get_element('ItemAttributes')
      # puts item_attributes.get('Title')
      # puts item_attributes.get('MediumImage/URL')


      # item_attributes.get_unescaped('Title') # unescape HTML entities
      # item_attributes.get_array('Author')    # ['Author 1', 'Author 2', ...]

      # Return a hash object with the element names as the keys
      # item.get_hash('SmallImage/URL') # {:url => ..., :width => ..., :height => ...}
      Product.create!(asin: asin, title: title, artist: artist)
    end
