class Room < ActiveRecord::Base
  belongs_to :building
  has_many :evaluations
  before_validation :assign_default_name

  has_many :room_pictures, dependent: :destroy

  #validates :building, presence: true
  validates :price, :square_meter, presence: true

  def assign_default_name
    self.optional_name = self.optional_name.presence || "A very nice room"
  end

end
