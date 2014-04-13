class AddTemperatureToAirQuality < ActiveRecord::Migration
  def change
    add_column :air_qualities, :temperature, :integer

  end
end
