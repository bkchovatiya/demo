require 'test_helper'

class OrdersControllerTest <  ActionDispatch::IntegrationTest
  test "should create order with from cart" do
    product_one = products(:product_one)
    product_one_addon_ids = [
      product_addons(:product_one_addon_one).id,
      product_addons(:product_one_addon_two).id,
      product_addons(:product_one_addon_three).id
    ]
    assert_difference('LineItem.count') do
      post add_to_cart_url, params: {product_id: product_one.id, product_addons: product_one_addon_ids, quantity: 10  }
    end

    assert_difference('Order.count') do
      get new_order_path
    end

    order = Order.last
    order_line_item_addons_ids = order.line_items.first.line_item_addons.pluck(:product_addon_id)
    assert_equal order.line_items.count, 1
    assert_equal order_line_item_addons_ids, product_one_addon_ids
    assert_equal 'Order has been successfully created!', flash[:success]
  end

  test "should not create order with invalid data" do
    assert_no_difference('Order.count') do
      get new_order_path
    end
  end
end
