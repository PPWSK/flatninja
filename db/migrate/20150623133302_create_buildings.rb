class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :building_type
      t.string :location
      t.integer :number_of_rooms
      t.integer :number_of_roommates
      t.boolean :garden, default: false
      t.boolean :balcony, default: false
      t.integer :bathroom
      t.integer :kitchen
      t.boolean :pets, default: false
      t.boolean :cleaning, default: false
      t.boolean :garage, default: false
      t.boolean :bike_storage, default: false

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
