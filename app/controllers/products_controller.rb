class ProductsController < ApplicationController

  def index
    @products = Product.includes(:product_addons).in_stock
  end
end
