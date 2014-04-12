class DashboardController < ApplicationController
  def index
    @current_location = Location.parse_from_cookie(cookies[:lat_long]) if cookies[:lat_long]
  end
end
