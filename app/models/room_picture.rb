class RoomPicture < ActiveRecord::Base
  belongs_to :room
  validates :file, presence: true
  validates :file_type, presence: true
  validates :room, presence: true

  validates :file_type, inclusion: { in: ["garden", "kitchen", "bathroom", "living room", "room for rent", "other"]}

  has_attached_file :file,
    styles: { original: "800x800>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\z/
end
