require "test_helper"

class Store::StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_store_index_url
    assert_response :success
  end
end
