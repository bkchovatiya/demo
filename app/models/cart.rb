class Cart < ApplicationRecord
  has_many :line_items, inverse_of: :cart
  has_many :products, through: :line_items

  validates :session_id, presence: true, uniqueness: true
end
