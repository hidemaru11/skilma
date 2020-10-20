require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plans_new_url
    assert_response :success
  end

end
