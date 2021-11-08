class MapsController < ApplicationController
  require 'net/http'
  MAX_SPOT_NUM = 5
  REMOVE_ADDRESS_REGEX = /.*〒\s?\d{3}(-|ー)\d{4}\s*/.freeze

  def map
    keyword = params[:keyword]
    nihongo = "https://maps.googleapis.com/maps/api/place/textsearch/json?" \
              "query=#{keyword}&" \
              "key=#{ENV['GOOGLE_API_KEY']}" \
              "&language=ja"
    uri_str = URI.encode nihongo
    url = URI.parse(uri_str)
    json = Net::HTTP.get(url)

    @spots = JSON.parse(json, { symbolize_names: true })[:results].first(MAX_SPOT_NUM)
    @spots.map! do |spot|
      spot[:formatted_address] = format_address(spot[:formatted_address])
      spot.slice(:name, :formatted_address, :geometry, :place_id)
    end
    session[:spots] = @spots

    respond_to do |format|
      format.js
    end
  end

  private

  def format_address(address)
    address.gsub(REMOVE_ADDRESS_REGEX, '')
  end
end
