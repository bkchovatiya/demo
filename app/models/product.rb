class Product < ApplicationRecord
  has_many :product_addons
  has_many :line_items
  has_many :orders, through: :line_items
  accepts_nested_attributes_for :product_addons
  scope :in_stock, -> { where(sold_out: false) }

  def is_sold_out?
    sold_out
  end
end
