class User < ActiveRecord::Base
  has_one :account
  has_many :buildings, dependent: :destroy
  has_many :pictures, dependent: :destroy

  validates :first_name, :last_name, :birth_date, :gender, :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :gender, inclusion: { in: ["female", "male"]}
end
