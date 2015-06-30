class Evaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :status, presence: true
end
