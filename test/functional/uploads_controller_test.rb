require 'test_helper'

class UploadsControllerNewTest < ActionController::TestCase
  tests UploadsController

  should "have a useful page title" do
    get :new

    assert_select 'head title', :text => "MoneyTracker - Upload statement"
  end
end