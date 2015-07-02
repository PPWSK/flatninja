class Evaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :messages

  validates :status, presence: true
  #TODO: uniqueness based on room + user
  validates :status, uniqueness: { scope: [:user_id, :room_id] }
end
