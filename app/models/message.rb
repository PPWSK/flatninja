class Message < ActiveRecord::Base
  belongs_to :evaluation
  validates :evaluation, presence: true
  validates :content, :recipient_id, presence: true
end
