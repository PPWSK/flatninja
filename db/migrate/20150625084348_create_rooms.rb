class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|

      t.references :building, index: true

      t.string :optional_name
      t.string :price
      t.date :available_from
      t.integer :months_available
      t.integer :square_meter
      t.boolean :private_bathroom
      t.boolean :private_kitchen
      t.boolean :private_balcony
      t.boolean :private_garden
      t.boolean :private_parking
      t.boolean :furnished
      t.boolean :valid_room
      t.boolean :published_room

      t.timestamps null: false
    end
  end
end
