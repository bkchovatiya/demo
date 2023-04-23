class CartsController < ApplicationController
  before_action :check_product_stock, :check_product_addon_count, :check_product_addons_stock, only: [:add_to_cart]


  def add_to_cart
    if add_line_item
      save_addons_to_line_item
    else
      flash[:error] = @cart_line_item.errors.full_messages.join(",")
    end

    redirect_to root_path
  end

  def cart
  end

  private

  def add_line_item
    @cart_line_item = @current_cart.line_items.find_or_initialize_by(product_id: product.id)
    params_quantity = params[:quantity] || 1
    quantity = @cart_line_item.id.present? ? (@cart_line_item.quantity + params_quantity) : params_quantity
    @cart_line_item.quantity = quantity

    @cart_line_item.save
  end

  def save_addons_to_line_item
    product_addons.each do |product_addon|
      line_item_addons = @cart_line_item.line_item_addons.find_or_initialize_by(product_addon_id: product_addon.id)
      if line_item_addons.save
        flash[:success] = 'Product has been added to yout cart.'
      else
        flash[:error] = line_item_addons.errors.full_messages.join(",")
      end
    end
  end

  def product
    @product ||= Product.in_stock.find_by(id: params['product_id'])
  end

  def product_addons
    @product_addons ||= ProductAddon.in_stock.where(id: params['product_addons'])
  end

  def check_product_stock
    if product.blank? || product.is_sold_out?
      flash[:error] = 'Product is sold out!'
      redirect_to root_path
    end
  end

  def check_product_addon_count
    if product_addons.count > 3
      flash[:error] = 'Max 3 addons are allowed!'
      redirect_to root_path
    end
  end

  def check_product_addons_stock
    if product_addons.count !=  params['product_addons'].to_a.count
      flash[:error] = 'One or More Product addon(s) are sold out!'
      redirect_to root_path
    end
  end
end
