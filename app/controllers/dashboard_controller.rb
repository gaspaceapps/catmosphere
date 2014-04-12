class DashboardController < ApplicationController
  def index
    if cookies[:lat_long]
      current_location = Location.parse_from_cookie(cookies[:lat_long])
      @air_quality = AirQuality.get(current_location.zipcode)
    end
  end
end
