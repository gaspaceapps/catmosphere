class AirQuality < ActiveRecord::Base
  def self.get(zipcode)
    cached_air_quality = self.find_by(zipcode: zipcode)
    if cached_air_quality and cached_air_quality.updated_at < (cached_air_quality.updated_at + 1.hour)
      cached_air_quality
    else
      endpoint = self.compile_today_endpoint(zipcode)
      air_quality_response = self.fetch(endpoint, zipcode)
      self.cacheify(air_quality_response)
    end
  end

  def self.get_tomorrow(zipcode)
    endpoint = self.compile_tomorrow_endpoint(zipcode)
    self.fetch(endpoint, zipcode)
  end

  def self.get_yesterday(zipcode)
    endpoint = self.compile_yesterday_endpoint(zipcode)
    self.fetch(endpoint, zipcode)
  end

  def self.fetch(endpoint, zipcode)
    parsed_response = JSON.parse(RestClient.get(endpoint))
    format_air_quality_hash(parsed_response, zipcode)
  end


  def self.get_temp(zipcode)
    endpoint = self.compile_temp_endpoint(zipcode)
    parsed_response = JSON.parse(RestClient.get(endpoint))
    parsed_response['current_observation']['temp_f']
  end

  private

  def self.format_air_quality_hash(response, zipcode)
    {
        zipcode: zipcode,
        aqi: response.last['AQI'],
        category_number: response.last['Category']['Number'],
        category_name: response.last['Category']['Name']
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

  def self.compile_tomorrow_endpoint(zipcode)
    "http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=#{zipcode}&date=#{(Time.now + 24.hours).strftime('%F')}&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end

  def self.compile_yesterday_endpoint(zipcode)
    "http://www.airnowapi.org/aq/observation/zipCode/historical/?format=application/json&zipCode=#{zipcode}&date=#{(Time.now - 24.hours).strftime('%F')}T00-0000&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end

  def self.compile_year_endpoint(zipcode)
    "http://www.airnowapi.org/aq/observation/zipCode/historical/?format=application/json&zipCode=#{zipcode}&date=#{(Time.now - 1.year).strftime('%F')}T00-0000&distance=25&API_KEY=408731F5-9C4F-4791-A3B9-E5BA5EE0F591"
  end


  def self.compile_temp_endpoint(zipcode)
    "http://api.wunderground.com/api/c0439c00830cfcd0/geolookup/conditions/q/IA/#{zipcode}.json"
  end


end
