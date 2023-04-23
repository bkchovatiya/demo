class LineItemAddon < ApplicationRecord
  belongs_to :line_item
  belongs_to :product_addon

  before_validation :check_addon_quantity
  before_validation :validate_product_addon_stock

  # Addons Should not be more than 3
  def check_addon_quantity
    errors.add(:product_addon, 'should not be more than 3') if line_item.line_item_addons.count > 3
  end

  def validate_product_addon_stock
    errors.add(:product_addon, 'is sold out!') if product_addon.is_sold_out?
  end
end
