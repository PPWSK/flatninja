class CreateRoomPictures < ActiveRecord::Migration
  def change
    create_table :room_pictures do |t|

      t.references :room, index: true

      t.string :file
      t.string :file_type

      t.timestamps null: false
    end
  end
end
