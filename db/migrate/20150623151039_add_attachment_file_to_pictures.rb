class AddAttachmentFileToPictures < ActiveRecord::Migration
  def self.up
    change_table :user_pictures do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :user_pictures, :file
  end
end
