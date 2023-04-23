# frozen_string_literal: true

class ProductPresenter < ApplicationPresenter
  def initialize(product)
    @product = product
  end

  def product_id
    @product.id
  end

  def name
    @product.name
  end

  def addons
    @product.product_addons.map { |e|  {id: e.id, name: e.name} }
  end

  def to_hash
    {
      id: product_id,
      name: name,
      addons: addons,
      price: '$0.00',
      product_image_url: 'https://dummyimage.com/450x300/dee2e6/6c757d.jpg'
    }
  end
end
