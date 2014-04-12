class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.integer :zipcode

      t.timestamps
    end
  end
end
