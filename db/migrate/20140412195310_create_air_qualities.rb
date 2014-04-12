class CreateAirQualities < ActiveRecord::Migration
  def change
    create_table :air_qualities do |t|
      t.integer :aqi
      t.integer :zipcode
      t.integer :category_number
      t.string :category_name

      t.timestamps
    end
  end
end
