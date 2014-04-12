class Location < ActiveRecord::Base

  def initialize
  @endpoint = "http://www.airnowapi.org/aq/observation/latLong/current/?format=application/json&latitude=#{lat}&longitude=-#{long}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end

  response = RestClient.get(endpoint)
  parsed_data = JSON.parse(response)

  aqi = parsed_data.first['AQI']


end
