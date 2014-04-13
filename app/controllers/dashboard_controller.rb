class DashboardController < ApplicationController
  def index
    if params[:zipcode]
      current_location = { zipcode: params[:zipcode] }
      @air_quality = AirQuality.get(current_location[:zipcode])
      @yesterday_air_quality = AirQuality.get_yesterday(current_location[:zipcode])
    elsif cookies[:lat_long]
      current_location = Location.parse_from_cookie(cookies[:lat_long])
      current_timezone = cookies[:current_timezone]
      @air_quality = AirQuality.get(current_location[:zipcode])
      @yesterday_air_quality = AirQuality.get_yesterday(current_location[:zipcode])
      @tomorrow_air_quality =   AirQuality.get_tomorrow(current_location[:zipcode])
    end
  end
end
