require "test_helper"

class SponsorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sponsor_index_url
    assert_response :success
  end
end
