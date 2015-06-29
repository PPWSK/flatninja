class Building < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :rooms
  has_many :building_pictures, dependent: :destroy

  accepts_nested_attributes_for :rooms, reject_if: proc { |attributes| attributes[:price].blank? || attributes[:square_meter].blank? }

  validates :user, presence: true
  validates :location, :number_of_rooms, :number_of_roommates, :building_type, presence: true
  validates :building_type, inclusion: { in: ["appartment", "house"]}

  geocoded_by :location
  after_validation :geocode, if: :location_changed?


end
