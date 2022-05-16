require "test_helper"

class MyReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_reservations_index_url
    assert_response :success
  end
end
