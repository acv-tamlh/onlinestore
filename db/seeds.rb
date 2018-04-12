#!/usr/bin/ruby

# require 'rubygems'
require 'google/api_client'
# require 'trollop'

# Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
# tab of
# {{ Google Cloud Console }} <{{ https://cloud.google.com/console }}>
# Please ensure that you have enabled the YouTube Data API for your project.
DEVELOPER_KEY = 'AIzaSyCWnD0gD9WbwXq2cDYOChwuF2MSPgVgDOI'
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

def get_service
  client = Google::APIClient.new(
    :key => DEVELOPER_KEY,
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
  )
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

  return client, youtube
end

def main

  categories = ['Phim']

  keywords = ['Phim hoạt hình', 'Chiến tranh']
  categories.each do |category|
    keywords.each do |kw|
      opts = Trollop::options do
        opt :q, 'Search term', :type => String, :default => kw
        opt :max_results, 'Max results', :type => :int, :default => 50
      end
      client, youtube = get_service

      begin
        search_response = client.execute!(
          :api_method => youtube.search.list,
          :parameters => {
            :part => 'snippet',
            :q => opts[:q],
            :maxResults => opts[:max_results]
          }
        )

        videos = []
        video_ids = []
        video_images = []
        channels = []
        playlists = []
        # puts   search_response.data.items.size
        # Add each result to the appropriate list, and then display the lists of
        # matching videos, channels, and playlists.
        search_response.data.items.each do |search_result|
          # puts search_result.snippet
          # puts search_result.id.kind
          case search_result.id.kind
            when 'youtube#video'
              videos << "#{search_result.snippet.title} (https://www.youtube.com/watch?v=#{search_result.id.videoId})"
              video_ids << "#{search_result.id.videoId}"
              video_images << "#{search_result.snippet.thumbnails.high.url}"
            when 'youtube#channel'
              channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
            when 'youtube#playlist'
              playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
          end
        end
        puts "Videos image: ", video_images, "\n"
        puts "Videos:\n", videos, "\n"
        puts "Channels:\n", channels, "\n"
        puts "Playlists:\n", playlists, "\n"
        # video_ids.each do |video_id|
          # puts "https://www.youtube.com/watch?v=" + video_id
        # end
      rescue Google::APIClient::TransmissionError => e
        puts e.result.body
      end
    end
  end

end

main
