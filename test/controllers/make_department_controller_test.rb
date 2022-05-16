require "test_helper"

class MakeDepartmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get make_department_index_url
    assert_response :success
  end
end
