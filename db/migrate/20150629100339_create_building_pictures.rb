class CreateBuildingPictures < ActiveRecord::Migration
  def change
    create_table :building_pictures do |t|

      t.references :building, index: true

      t.string :file
      t.string :file_type

      t.timestamps null: false
    end
  end
end
