class AirQuality < ActiveRecord::Base
  def self.get(zipcode)
    found = self.find_by(zipcode: zipcode)
    if found
      found
    else
      endpoint = self.compile_endpoint(zipcode)
      response = RestClient.get(endpoint)
      parsed_response = JSON.parse(response)

      air_quality_response = {
          zipcode: zipcode,
          aqi: parsed_response.first['AQI'],
          category_number: parsed_response.first['Category']['Number'],
          category_name: parsed_response.first['Category']['Name']
      }
      self.cacheify(air_quality_response)
    end
  end

  private

  def self.cacheify(air_quality_response)

    self.find_or_create_by(zipcode: air_quality_response[:zipcode] ) do |air_quality|
      air_quality.aqi = air_quality_response[:aqi]
      air_quality.category_number = air_quality_response[:category_number]
      air_quality.category_name = air_quality_response[:category_name]
    end
  end

  def self.compile_endpoint(zipcode)
    "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{zipcode}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end
end
