require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  setup do
    @stat = stats(:one)
  end
  test "should show stat" do
    get :show, id: @stat
    assert_response :success
  end
end
