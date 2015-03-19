require 'test_helper'

class TransactionsControllerIndexTest < ActionController::TestCase
  tests TransactionsController

  test 'should redirect to the most recent period' do
    current_period = Date.today.to_s(:period)

    get :index

    assert_redirected_to transactions_path(period: current_period)
  end

  test 'should add a class to the first transaction on a given day' do
    today = Date.today
    transaction_1 = FactoryGirl.create(:transaction, date: today)
    transaction_2 = FactoryGirl.create(:transaction, date: today)

    get :index, period: today.to_s(:period)

    assert_select "#transaction_#{transaction_1.id} .date.firstOfDay"
    assert_select "#transaction_#{transaction_2.id} .date"
    assert_select "#transaction_#{transaction_2.id} .date.firstOfDay", count: 0
  end

  test 'should include the period in the page title' do
    today = Date.today

    get :index, period: today.to_s(:period)

    assert_select 'head title', text: "MoneyTracker - Transactions for #{today.to_s(:month_and_year)}"
  end

  test 'should link to a map of the location' do
    FactoryGirl.create(:transaction, location: 'London EC2A')

    get :index, period: Date.today.to_s(:period)

    assert_select "a[title='View in Google Maps']"
  end

  test 'should display the name of the account the transaction belongs to' do
    account = FactoryGirl.create(:account, name: 'account-name')
    FactoryGirl.create(:transaction, account: account)
    today = Date.today

    get :index, period: today.to_s(:period)

    assert_select '.account', text: 'account-name'
  end
end

class TransactionsControllerBulkEditTest < ActionController::TestCase
  tests TransactionsController

  test 'displays the edit form' do
    FactoryGirl.create(:transaction)

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select "input[name='transaction[date]']"
    assert_select "input[name='transaction[description]']"
    assert_select "input[name='transaction[location]']"
    assert_select "textarea[name='transaction[note]']"
    assert_select "input[name='transaction[category]']"
  end

  test 'displays the account name in the edit form' do
    account = FactoryGirl.create(:account, name: 'account-name')
    FactoryGirl.create(:transaction, account_id: account.id)

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select '.account_name', 'account-name'
  end

  test 'should display original values in the edit form' do
    date   = Date.parse('2011-01-01')
    period = date.to_s(:period)
    transaction = FactoryGirl.create(:transaction, name: 'name', memo: 'memo', type: 'type', source_date: date)

    get :index, period: period, edit: true

    assert_equal date, transaction.date
    assert_equal 'name / memo (type)', transaction.description

    assert_select "input[name='transaction[date]'][value='#{date}']"
    assert_select "input[name='transaction[description]'][value='name / memo (type)']"
    assert_select "textarea[name='transaction[note]']", text: ''
  end

  test 'should display original date in the edit form' do
    date   = Date.parse('2011-01-01')
    period = date.to_s(:period)
    FactoryGirl.create(:transaction, source_date: date)

    get :index, period: period, edit: true

    assert_select '.source_date', '2011-01-01'
  end

  test 'should display original description in the edit form' do
    transaction = FactoryGirl.create(:transaction)
    transaction.original_description = 'original-description'
    transaction.save!

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select '.original_description', 'original-description'
  end

  test 'should display user-entered values in the edit form' do
    date   = Date.parse('2011-01-01')
    period = date.to_s(:period)
    FactoryGirl.create :transaction, description: 'custom-description', date: date, note: 'custom-note'

    get :index, period: period, edit: true

    assert_select "input[name='transaction[date]'][value='#{date}']"
    assert_select "input[name='transaction[description]'][value='custom-description']"
    assert_select "textarea[name='transaction[note]']", text: 'custom-note'
  end

  test 'adds a category class to the category field to enable autocomplete' do
    FactoryGirl.create(:transaction, category: 'category-name')

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select 'input.category', value: 'category-name'
  end

  test 'adds a description class to the description field to enable autocomplete' do
    FactoryGirl.create(:transaction, description: 'description-name')

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select 'input.description', value: 'description-name'
  end

  test 'adds a location class to the location field to enable autocomplete' do
    FactoryGirl.create(:transaction, location: 'location-name')

    get :index, period: Date.today.to_s(:period), edit: true

    assert_select 'input.location', value: 'location-name'
  end

  test 'should link to the edit form of the previous and next period' do
    get :index, period: Date.parse('2011-08-01').to_s(:period), edit: 'true'

    assert_select 'a.previous_period[href=?]', transactions_path(period: '2011-07', edit: true)
    assert_select 'a.next_period[href=?]', transactions_path(period: '2011-09', edit: true)
  end

  test 'should include the period in the page title' do
    today = Date.today

    get :index, period: today.to_s(:period), edit: true

    assert_select 'head title', text: "MoneyTracker - Edit transactions for #{today.to_s(:month_and_year)}"
  end
end

class TransactionsControllerSearchTest < ActionController::TestCase
  tests TransactionsController

  test 'should display the search string in the search form' do
    get :search, q: 'search-string'

    assert_select "#q[value='search-string']"
  end

  test 'should add a class to the first transaction on a given day' do
    today = Date.today
    FactoryGirl.create(:transaction, date: today, description: 'test description')
    FactoryGirl.create(:transaction, date: today, description: 'test description')

    get :search, q: 'test description'

    assert_select '.transaction .date', count: 2
    assert_select '.transaction .date.firstOfDay', count: 1
  end

  test 'should include the search string in the page title' do
    get :search, q: 'test description'

    assert_select 'head title', text: "MoneyTracker - Transactions matching 'test description'"
  end
end

class TransactionsControllerSearchAndEditTest < ActionController::TestCase
  tests TransactionsController

  test 'should not display the edit link' do
    get :search, q: 'search-string', edit: 'true'

    assert_select 'a', text: 'Edit', count: 0
  end

  test 'should not display the period navigation links' do
    get :search, q: 'search-string', edit: 'true'

    assert_select 'a.previous_period', count: 0
    assert_select 'a.next_period', count: 0
  end

  test 'should include the search string in the page title' do
    get :search, q: 'search-string', edit: true

    assert_select 'head title', text: "MoneyTracker - Edit transactions matching 'search-string'"
  end
end

class TransactionsControllerEditTest < ActionController::TestCase
  tests TransactionsController

  test 'should have a useful page title' do
    transaction = FactoryGirl.create(:transaction)

    get :edit, id: transaction.id

    assert_select 'head title', text: 'MoneyTracker - Edit transaction'
  end

  test 'displays the edit form' do
    transaction = FactoryGirl.create(:transaction)

    get :edit, id: transaction

    assert_select "input[name='transaction[date]']"
    assert_select "input[name='transaction[description]']"
    assert_select "input[name='transaction[location]']"
    assert_select "textarea[name='transaction[note]']"
    assert_select "input[name='transaction[category]']"
  end

  test 'displays the account name in the edit form' do
    account = FactoryGirl.create(:account, name: 'account-name')
    transaction = FactoryGirl.create(:transaction, account_id: account.id)

    get :edit, id: transaction

    assert_select '.account_name', 'account-name'
  end

  test 'displays the original date in the edit form' do
    date   = Date.parse('2011-01-01')
    transaction = FactoryGirl.create(:transaction, source_date: date)

    get :edit, id: transaction

    assert_select '.source_date', '2011-01-01'
  end

  test 'should display original description in the edit form' do
    transaction = FactoryGirl.create(:transaction)
    transaction.original_description = 'original-description'
    transaction.save!

    get :edit, id: transaction

    assert_select '.original_description', 'original-description'
  end

  test 'adds a category class to the category field to enable autocomplete' do
    transaction = FactoryGirl.create(:transaction, category: 'category-name')

    get :edit, id: transaction

    assert_select 'input.category', value: 'category-name'
  end

  test 'adds a description class to the description field to enable autocomplete' do
    transaction = FactoryGirl.create(:transaction, description: 'description-name')

    get :edit, id: transaction

    assert_select 'input.description', value: 'category-name'
  end

  test 'adds a location class to the location field to enable autocomplete' do
    transaction = FactoryGirl.create(:transaction, location: 'location-name')

    get :edit, id: transaction

    assert_select 'input.location', value: 'location-name'
  end

  test 'adds a transaction class to the form to enable autocomplete of the location field' do
    transaction = FactoryGirl.create(:transaction)

    get :edit, id: transaction

    assert_select 'form.edit_transaction.transaction'
  end
end

class TransactionsControllerUpdateTest < ActionController::TestCase
  tests TransactionsController

  test 'should update transaction and redirect back' do
    request.env['HTTP_REFERER'] = '/previous-location'

    transaction = FactoryGirl.create(:transaction,
                                     date: Date.today,
                                     description: 'old-description',
                                     location: 'old-location',
                                     note: 'old-note',
                                     category: 'old-category'
    )

    put :update, id: transaction, transaction: {
      date: Date.yesterday, description: 'new-description', location: 'new-location',
      note: 'new-note', category: 'new-category'
    }
    transaction.reload

    assert_redirected_to '/previous-location'

    assert_equal Date.yesterday, transaction.date
    assert_equal 'new-description', transaction.description
    assert_equal 'new-location', transaction.location
    assert_equal 'new-note', transaction.note
    assert_equal 'new-category', transaction.category
  end
end
