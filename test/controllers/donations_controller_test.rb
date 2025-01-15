require "test_helper"

class DonationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_donation_url
    assert_response :success
  end

  test "should create donation" do
    post donations_url, params: { donation: { amount: 1000 } }
    assert_redirected_to root_path
  end
end
