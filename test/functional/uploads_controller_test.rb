require 'test_helper'

class UploadsControllerNewTest < ActionController::TestCase
  tests UploadsController

  test "should have a useful page title" do
    get :new

    assert_select 'head title', text: "MoneyTracker - Upload statement"
  end
end