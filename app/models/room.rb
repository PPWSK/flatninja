class Room < ActiveRecord::Base
  belongs_to :building
  before_validation :assign_default_name

  has_many :room_pictures, dependent: :destroy

  #validates :building, presence: true
  validates :price, :square_meter, presence: true

  def strip_whitespace
    self.name = self.name.presence || "A very nice room"
  end

end
