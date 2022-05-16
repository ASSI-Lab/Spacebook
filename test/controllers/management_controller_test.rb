require "test_helper"

class ManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get management_index_url
    assert_response :success
  end
end
