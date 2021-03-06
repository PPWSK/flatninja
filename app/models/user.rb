class User < ActiveRecord::Base
  has_one :account
  has_many :buildings, dependent: :destroy
  has_many :user_pictures, dependent: :destroy
  has_many :rooms, through: :buildings
  has_many :evaluations

  validates :first_name, :last_name, :birth_date, :gender, :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :gender, inclusion: { in: ["female", "male"]}
end
