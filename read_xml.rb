require 'nokogiri'

f = File.open('./demo.xml')
# f = File.open('./onlinestore-onepice.xml')
doc = Nokogiri::XML(f)
root = doc.root
items = root.xpath("Items/Item")
puts items.count
puts items[0].xpath("Keywords")
