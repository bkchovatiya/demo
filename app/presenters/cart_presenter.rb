# frozen_string_literal: true

class CartPresenter < ApplicationPresenter
  def initialize(cart)
    @cart = cart
  end

  def total_line_items
    @cart.line_items.sum(:quantity)
  end

  def line_items
    @cart.line_items.map { |e|  { name: e.product.name, quantity: e.quantity, addons: line_item_addons(e), price: 0.0, total: 0.0  } }
  end

  def line_item_addons(line_item)
    line_item.line_item_addons.map { |e| e.product_addon.name }.join(',')
  end

  def to_hash
    {
      cart_id: @cart.id,
      line_items: line_items,
      total_line_items: total_line_items,
      sub_total: 0,
      tax: 0,
      total: 0
    }
  end
end
