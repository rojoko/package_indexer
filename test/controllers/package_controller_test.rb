require 'test_helper'

class PackageControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get package_list_url
    assert_response :success
  end

end
