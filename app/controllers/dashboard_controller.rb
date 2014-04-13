class DashboardController < ApplicationController
  def index
    if cookies[:lat_long]
      current_location = Location.parse_from_cookie(cookies[:lat_long])
      @air_quality = AirQuality.get(current_location[:zipcode])
      @yesterday_air_quality = AirQuality.get_yesterday(current_location[:zipcode])
      @tomorrow_air_quality = AirQuality.get_tomorrow(current_location[:zipcode])
      @temp = AirQuality.get_temp(current_location[:zipcode])
    end
  end

  def zipcode
    if params[:zipcode]
      current_location = { zipcode: params[:zipcode] }
      @air_quality = AirQuality.get(current_location[:zipcode])
      @yesterday_air_quality = AirQuality.get_yesterday(current_location[:zipcode])
      @tomorrow_air_quality = AirQuality.get_tomorrow(current_location[:zipcode])
      @temp = AirQuality.get_temp(current_location[:zipcode])
      render template: 'dashboard/index'
    end
  end
end
