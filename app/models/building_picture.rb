class BuildingPicture < ActiveRecord::Base
  belongs_to :building
  validates :file, presence: true
  validates :file_type, presence: true
  validates :building, presence: true

  has_attached_file :file,
    styles: { original: "800x800>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\z/
end
