require 'test_helper'

class TransactionsControllerIndexTest < ActionController::TestCase
  tests TransactionsController
  
  should "redirect to the most recent period" do
    current_period = Date.today.to_s(:period)
    
    get :index
    
    assert_redirected_to transactions_path(:period => current_period)
  end
  
  should "add a class to the first transaction on a given day" do
    today = Date.today
    transaction_1 = Factory.create(:transaction, :date => today)
    transaction_2 = Factory.create(:transaction, :date => today)
    
    get :index, :period => today.to_s(:period)

    assert_select "#transaction_#{transaction_1.id} .date.firstOfDay"
    assert_select "#transaction_#{transaction_2.id} .date"
    assert_select "#transaction_#{transaction_2.id} .date.firstOfDay", :count => 0
  end

end

class TransactionsControllerEditTest < ActionController::TestCase
  tests TransactionsController
  
  should "display original values in the edit form" do
    date   = Date.parse('2011-01-01')
    period = date.to_s(:period)
    transaction = Factory.create(:transaction, :name => 'name', :memo => 'memo', :type => 'type', :original_date => date)
    
    get :index, :period => period, :edit => true

    assert_equal date, transaction.date
    assert_equal 'name / memo (type)', transaction.description
    
    assert_select "input[name='transaction[date]'][value='#{date}']"
    assert_select "input[name='transaction[description]'][value='name / memo (type)']"
    assert_select "textarea[name='transaction[note]']", :text => ''
  end
  
  should "display user-entered values in the edit form" do
    date   = Date.parse('2011-01-01')
    period = date.to_s(:period)
    Factory.create :transaction, :description => 'custom-description', :date => date, :note => 'custom-note'
    
    get :index, :period => period, :edit => true
  
    assert_select "input[name='transaction[date]'][value='#{date}']"
    assert_select "input[name='transaction[description]'][value='custom-description']"
    assert_select "textarea[name='transaction[note]']", :text => 'custom-note'
  end
  
  should "display the period navigation links" do
    get :index, :period => Date.parse('2011-01-01').to_s(:period), :edit => 'true'
  
    assert_select 'a.previous_period', :count => 1
    assert_select 'a.next_period', :count => 1
  end
  
end

class TransactionsControllerSearchTest < ActionController::TestCase
  tests TransactionsController
  
  should "display the search string in the search form" do
    get :search, :q => 'search-string'
    
    assert_select "#q[value='search-string']"
  end
  
  should "add a class to the first transaction on a given day" do
    today = Date.today
    transaction_1 = Factory.create(:transaction, :date => today, :description => 'test description')
    transaction_2 = Factory.create(:transaction, :date => today, :description => 'test description')
    
    get :search, :q => 'test description'

    assert_select "#transaction_#{transaction_1.id} .date.firstOfDay"
    assert_select "#transaction_#{transaction_2.id} .date"
    assert_select "#transaction_#{transaction_2.id} .date.firstOfDay", :count => 0
  end
  
end

class TransactionsControllerSearchAndEditTest < ActionController::TestCase
  tests TransactionsController
  
  should "not display the edit link" do
    get :search, :q => 'search-string', :edit => 'true'

    assert_select 'a', :text => 'Edit', :count => 0
  end
  
  should "not display the period navigation links" do
    get :search, :q => 'search-string', :edit => 'true'
  
    assert_select 'a.previous_period', :count => 0
    assert_select 'a.next_period', :count => 0
  end
  
end