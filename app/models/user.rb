class User < ActiveRecord::Base
  has_one :account
  validates :first_name, :last_name, :birth_date, :gender, :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :gender, inclusion: { in: ["female", "male"]}
end
