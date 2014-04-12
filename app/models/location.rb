class Location < ActiveRecord::Base
  @endpoint = "http://www.airnowapi.org/aq/observation/latLong/current/?format=application/json&latitude=#{lat}&longitude=-#{long}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
end
