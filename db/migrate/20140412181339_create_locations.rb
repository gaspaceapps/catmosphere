class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :lat
      t.integer :long
      t.integer :zipcode
      t.integer :categoryNumber

      t.timestamps
    end
  end
end
