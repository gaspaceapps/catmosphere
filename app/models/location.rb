class Location < ActiveRecord::Base
  def self.parse_from_cookie(cookie)
    split_cookie = cookie.split('|')
    parsed_cookie = { latitude: split_cookie.first, longitude: split_cookie.last }
    self.cacheify(parsed_cookie)
  end

  def self.cacheify(cookie)
    zipcode = self.get_zipcode(cookie[:latitude], cookie[:longitude])
    self.find_or_create_by(zipcode: zipcode) do |location|
      location.latitude = cookie[:latitude]
      location.longitude = cookie[:longitude]
    end
  end

  def self.get_zipcode(latitude, longitude)
    Geocoder.search("#{latitude},#{longitude}").first.data['address_components'].last['long_name']
  end
end
