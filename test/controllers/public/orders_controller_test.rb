require "test_helper"

class Public::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get public_orders_confirm_url
    assert_response :success
  end
end
