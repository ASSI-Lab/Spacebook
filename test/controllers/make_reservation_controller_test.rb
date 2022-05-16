require "test_helper"

class MakeReservationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get make_reservation_index_url
    assert_response :success
  end
end
