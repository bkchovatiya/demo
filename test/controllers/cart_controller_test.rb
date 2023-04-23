require 'test_helper'

class CartControllerTest <  ActionDispatch::IntegrationTest
    test "it should add product to cart" do
      product = products(:product_one)
      product_addon = product_addons(:product_one_addon_one)

      assert_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product.id, product_addons: [product_addon.id], quantity: 1  }
      end
    end

    test "it should not add product to cart when quantity is more than 24" do
      product = products(:product_one)
      product_addon = product_addons(:product_one_addon_one)

      assert_no_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product.id, product_addons: [product_addon.id], quantity: 25  }
      end
    end

    test "it should not add product to cart when quantity is more than 24 with multiple products" do
      product_one = products(:product_one)
      product_one_addon_ids = [
        product_addons(:product_one_addon_one).id,
        product_addons(:product_one_addon_two).id,
        product_addons(:product_one_addon_three).id
      ]
      assert_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product_one.id, product_addons: product_one_addon_ids, quantity: 10  }
      end

      product_two = products(:product_two)
      product_two_addon_ids = [
        product_addons(:product_two_addon_one).id,
        product_addons(:product_two_addon_two).id
      ]
      assert_no_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product_two.id, product_addons: product_two_addon_ids, quantity: 20  }
      end
    end

    test "it should not add product to cart when addon are more than 3" do
      product = products(:product_one)
      product_addon_ids = [
        product_addons(:product_one_addon_one).id,
        product_addons(:product_one_addon_two).id,
        product_addons(:product_one_addon_three).id,
        product_addons(:product_one_addon_four).id
      ]

      assert_no_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product.id, product_addons: product_addon_ids, quantity: 1  }
      end
    end

    test "it should not add product to cart when product is sold out" do
      product = products(:product_sold_out)
      product_addon = product_addons(:product_sold_out_addon_one)

      assert_no_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product.id, product_addons: [product_addon.id], quantity: 1  }
      end
    end

    test "it should not add product to cart when product addon is sold out" do
      product = products(:product_one)
      product_addon = product_addons(:product_one_addon_five)

      assert_no_difference('LineItem.count') do
        post add_to_cart_url, params: {product_id: product.id, product_addons: [product_addon.id] }
      end
    end
end
