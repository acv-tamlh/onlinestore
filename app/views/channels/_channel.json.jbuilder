json.extract! channel, :id, :title, :description, :thumbnails_default, :thumbnails_high, :created_at, :updated_at
json.url channel_url(channel, format: :json)
