require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  
  should "redirect to the most recent period" do
    current_period = Date.today.strftime("%Y-%m")
    
    get :index
    
    assert_redirected_to transactions_path(:period => current_period)
  end
  
end