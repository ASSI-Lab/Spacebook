require "test_helper"

class InformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get informations_index_url
    assert_response :success
  end
end
