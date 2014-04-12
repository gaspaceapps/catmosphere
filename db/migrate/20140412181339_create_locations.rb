class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.integer :zipcode
      t.integer :categoryNumber

      t.timestamps
    end
  end
end
