class Building < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :rooms
  accepts_nested_attributes_for :rooms

  validates :user, presence: true
  validates :location, :number_of_rooms, :number_of_roommates, :building_type, presence: true
  validates :building_type, inclusion: { in: ["appartment", "house"]}

  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
