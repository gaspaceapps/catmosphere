class AirQuality < ActiveRecord::Base
  def self.get(zipcode)
    cached_air_quality = self.find_by(zipcode: zipcode)
    if cached_air_quality
      cached_air_quality
    else
      endpoint = self.compile_today_endpoint(zipcode)
      parsed_response = JSON.parse(RestClient.get(endpoint))
      air_quality_response = format_air_quality_hash(parsed_response, zipcode)
      self.cacheify(air_quality_response)
    end
  end

  private

  def self.format_air_quality_hash(response, zipcode)
    {
        zipcode: zipcode,
        aqi: response.first['AQI'],
        category_number: response.first['Category']['Number'],
        category_name: response.first['Category']['Name']
    }
  end

  def self.cacheify(air_quality_response)
    self.find_or_create_by(zipcode: air_quality_response[:zipcode] ) do |air_quality|
      air_quality.aqi = air_quality_response[:aqi]
      air_quality.category_number = air_quality_response[:category_number]
      air_quality.category_name = air_quality_response[:category_name]
    end
  end

  def self.compile_today_endpoint(zipcode)
    "http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{zipcode}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end
end
