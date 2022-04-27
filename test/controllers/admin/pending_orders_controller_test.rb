require "test_helper"

class Admin::PendingOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_pending_orders_index_url
    assert_response :success
  end
end
