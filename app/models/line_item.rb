class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :cart, optional: true
  belongs_to :product
  has_many :line_item_addons
  has_many :product_addons, through: :line_item_addons

  before_validation :validate_product_stock
  before_validation :check_order_quantity

  # Order Total Quantity Should not be more than 24
  def check_order_quantity
    if cart
      cart_line_item_quantity_count = cart.line_items.where.not(id: self.id).sum(:quantity)
      errors.add(:quantity, 'should not be more than 25.') if (cart_line_item_quantity_count+ self.quantity) > 24
    end
  end

  def validate_product_stock
    errors.add(:product, 'is sold out!') if product.is_sold_out?
  end
end
