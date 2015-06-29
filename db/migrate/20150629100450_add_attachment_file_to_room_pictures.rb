class AddAttachmentFileToRoomPictures < ActiveRecord::Migration
    def self.up
    change_table :room_pictures do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :room_pictures, :file
  end
end
