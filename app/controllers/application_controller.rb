class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_cart

  private
  def current_cart
    if session[:cart_session_id]
      cart = Cart.includes(line_items: [:product, line_item_addons:[:product_addon]])
                 .where(session_id: session[:cart_session_id]).first
      if cart.present?
        @current_cart = cart
      else
        session[:cart_session_id] = nil
      end
    end

    if session[:cart_session_id] == nil
      @current_cart = Cart.create(session_id: SecureRandom.hex)
      session[:cart_session_id] = @current_cart.session_id
    end
  end
end
