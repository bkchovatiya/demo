class OrdersController < ApplicationController
  before_action :check_cart_data

  def new
    @order = customer.orders.new

    move_cart_line_items_in_order

    destroy_current_cart

    flash[:success] = 'Order has been successfully created!'

    redirect_to root_path
  end

  private

  def check_cart_data
    redirect_to root_path if @current_cart.line_items.blank?
  end

  def move_cart_line_items_in_order
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end

    @order.save
  end

  def destroy_current_cart
    @current_cart.destroy
    session[:cart_session_id] = nil
  end

  def customer
    @customer ||= Customer.first
  end
end
