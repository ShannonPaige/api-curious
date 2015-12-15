require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "twitter user can login using their twitter profile" do
    visit '/'
    assert_equal 200, page.status_code
    click_link "Login"
    assert_equal "/", current_path
    assert page.has_content?("Shannon")
    assert page.has_link?("Logout")
  end

  # test "twitter user can login using their twitter profile" do
  #   visit '/'
  #   assert_equal 200, page.status_code
  #   click_link "Login"
  #   assert_equal "/", current_path
  #   assert page.has_content?("Shannon")
  #   assert page.has_link?("Logout")
  # end
end
