class Customer < ApplicationRecord
  validates :first_name, :last_name, :email, :mobile_no, :address, presence: true
  has_many :orders
end
