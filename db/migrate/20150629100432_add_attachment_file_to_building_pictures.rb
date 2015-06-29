class AddAttachmentFileToBuildingPictures < ActiveRecord::Migration
    def self.up
    change_table :building_pictures do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :building_pictures, :file
  end
end
