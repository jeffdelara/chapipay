require "test_helper"

class Store::PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_payments_index_url
    assert_response :success
  end

  test "should get show" do
    get store_payments_show_url
    assert_response :success
  end

  test "should get create" do
    get store_payments_create_url
    assert_response :success
  end
end
