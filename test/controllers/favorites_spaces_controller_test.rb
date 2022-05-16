require "test_helper"

class FavoritesSpacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favorites_spaces_index_url
    assert_response :success
  end
end
