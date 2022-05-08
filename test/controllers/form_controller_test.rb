require "test_helper"

class FormControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get form_form_url
    assert_response :success
  end
end
