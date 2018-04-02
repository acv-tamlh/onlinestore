# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  require 'amazon/ecs'

  ACCESS_KEY_ID = "AKIAJWPWTVNYFLW7EKHQ"

  # Your Secret Key corresponding to the above ID, as taken from the Your Account page
  SECRET_KEY = "C9ZIPiqI5j31xbH8N83rNOzp4XAQ8FuRlVUGlMTy"

  # The region you are interested in
  ENDPOINT = "webservices.amazon.in"

  REQUEST_URI = "/onca/xml"

  ASSOCIATE_TAG = 'onlinestore'


    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = ACCESS_KEY_ID
      options[:AWS_secret_key] = SECRET_KEY
      options[:associate_tag] = ASSOCIATE_TAG
    end
    # To replace default options
    # Amazon::Ecs.options = { ... }

    # To override default options
    # res = Amazon::Ecs.item_search('strategy', {
    #                               #:search_index => 'All',
    #                               :response_group => 'Images, ItemAttributes, Medium, Images',
    #                               :sort => 'salesrank',
    #                               :country => 'in'})

    # puts res.is_valid_request?
    # puts res.has_error?
    # puts res.error                                 # error message
    # puts res.total_pages
    # puts res.total_results
    # res.item_page                             # current page no if :item_page option is provided

    # Find elements matching 'Item' in response object
    # res.items.each do |item|
    #   # Retrieve string value using XML path
    #   asin = item.get('ASIN')
    #   title = item.get('ItemAttributes/Title')
    #   artist = item.get('ItemAttributes/Artist')
    #   puts item.get('ItemAttributes/ProductGroup')
      # puts '======='
      # puts asin
      # puts title
      # puts artist

      # puts item.get('ItemAttributes/Manufacturer')
      # puts item.get('ItemAttributes/Creator')

      # Return Amazon::Element instance
      # puts item_attributes = item.get_element('ItemAttributes')
      # puts item_attributes.get('Title')
      # puts item_attributes.get('MediumImage/URL')


      # item_attributes.get_unescaped('Title') # unescape HTML entities
      # item_attributes.get_array('Author')    # ['Author 1', 'Author 2', ...]

      # Return a hash object with the element names as the keys
      # item.get_hash('SmallImage/URL') # {:url => ..., :width => ..., :height => ...}
      # Product.create!(asin: asin, title: title, artist: artist)
    # end

productGroups = ['Book',
                  'DVD',
                  'Toys',
                  'VideoGames',
                  'All'
                  ]
productGroups.each do |productGroup|
  # prg = ProductGroup.create(title: productGroup)
  res = Amazon::Ecs.item_search('strategy', {
                                :search_index => productGroup,
                                :response_group => 'Medium',
                                :sort => 'salesrank',
                                # :country => 'in'
                                })
  res.items.each do |item|
    item_attributes = item.get_element('ItemAttributes')
    # puts item
    asin = item.get('ASIN')
    title = item.get('ItemAttributes/Title')
    artist = item.get('ItemAttributes/Artist')
    image = item.get('MediumImage/URL')
    price = item_attributes.get("ListPrice/FormattedPrice")
    refurl = item.get('DetailPageURL')
    description = item.get('EditorialReviews/EditorialReview/Content')
    puts res.error                                 # error message
    # puts res.has_error?
    puts asin
    puts title
    puts artist
    puts image
    puts price
    puts refurl
    puts description
  end
  # puts '@==========================================@'
  # ProductGroup.create(title: productGroup)
  # Product.create!(asin: asin
  #               , title: title
  #               , artist: artist
  #               , price: price
  #               , productgroups_id: prg.id
  #               , image: image
  #               , refurl: refurl
  #               , description: description
  #             )

end
