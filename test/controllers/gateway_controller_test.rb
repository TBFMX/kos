require 'test_helper'

class GatewayControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get paypal" do
    get :paypal
    assert_response :success
  end

  test "should get dineromail" do
    get :dineromail
    assert_response :success
  end

end
