class Location < ActiveRecord::Base
  def self.parse_from_cookie(cookie)
    split_cookie = cookie.split('|')
    parsed_cookie = { latitude: split_cookie.first.to_f, longitude: split_cookie.last.to_f }
    zipcode = self.get_zipcode(parsed_cookie[:latitude], parsed_cookie[:longitude])
    parsed_cookie.merge({zipcode: zipcode.to_i})
  end

  private

  def self.get_zipcode(latitude, longitude)
    Geocoder.search("#{latitude},#{longitude}").first.data['address_components'].last['long_name']
  end
end
