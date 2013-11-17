require 'test_helper'

class UploadsControllerNewTest < ActionController::TestCase
  tests UploadsController

  test 'should have a useful page title' do
    get :new

    assert_select 'head title', text: 'MoneyTracker - Upload statement'
  end

  test 'should explain that uploads have been disabled in the demo' do
    in_demo_mode do
      get :new

      assert_select 'p', text: 'Uploads have been disabled in the demo'
    end
  end
end
