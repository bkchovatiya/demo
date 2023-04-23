class ProductAddon < ApplicationRecord
  belongs_to :product
  has_many :line_item_addons

  scope :in_stock, -> { where(sold_out: false) }

  def is_sold_out?
    sold_out
  end
end
