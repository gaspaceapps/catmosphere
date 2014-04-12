class AirQuality < ActiveRecord::Base
  def self.get(zipcode)
    endpoint = self.compile_endpoint(zipcode)
    response = RestClient.get(endpoint)
    parsed_response = JSON.parse(response)
  end

  private

  def self.compile_endpoint(zipcode)
    "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{zipcode}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end
end
