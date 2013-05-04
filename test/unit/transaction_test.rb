# encoding: utf-8
require 'test_helper'

class TransactionProtectedAttributesTest < ActiveSupport::TestCase
  {
    original_date:   Date.parse('2011-01-01'),
    name:            'ofx-name',
    amount_in_pence: 123,
    type:            'ofx-type',
    fit_id:          'ofx-fit-id',
    memo:            'ofx-memo',
    original_description: 'original-description'
  }.each do |protected_attribute, value|
    test "should not allow mass assignment of #{protected_attribute}" do
      assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Transaction.new(protected_attribute => value) }
    end
  end
end

class TransactionValidationTest < ActiveSupport::TestCase
  test 'should be valid when build from the factory' do
    transaction = FactoryGirl.build(:transaction)
    assert transaction.valid?
  end

  test 'should be invalid without an account_id' do
    transaction = FactoryGirl.build(:transaction, account_id: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid without an original date' do
    transaction = FactoryGirl.build(:transaction, original_date: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid without a name' do
    transaction = FactoryGirl.build(:transaction, name: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid without an amount in pence' do
    transaction = FactoryGirl.build(:transaction, amount_in_pence: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid without an ofx type' do
    transaction = FactoryGirl.build(:transaction, type: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid without an original description' do
    transaction = FactoryGirl.create(:transaction)
    transaction.original_description = nil
    assert ! transaction.valid?
  end

  test 'should be invalid without a fit_id' do
    transaction = FactoryGirl.build(:transaction, fit_id: nil)
    assert ! transaction.valid?
  end

  test 'should be invalid unless the fit_id is unique' do
    FactoryGirl.create(:transaction, fit_id: '123')
    assert_raise(ActiveRecord::RecordInvalid) { FactoryGirl.create(:transaction, fit_id: '123') }
  end
end

class TransactionSearchTest < ActiveSupport::TestCase
  test 'should search Transaction#name' do
    t1 = FactoryGirl.create(:transaction, name: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, name: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#memo' do
    t1 = FactoryGirl.create(:transaction, memo: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, memo: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#note' do
    t1 = FactoryGirl.create(:transaction, note: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, note: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#type' do
    t1 = FactoryGirl.create(:transaction, type: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, type: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#description' do
    t1 = FactoryGirl.create(:transaction, description: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, description: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should filter by Transaction#category' do
    t1 = FactoryGirl.create(:transaction, category: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, category: 'no-match')
    assert_equal [t1], Transaction.search('category:MATCHING TRANSACTION')
  end

  test 'should filter by Transaction#description' do
    t1 = FactoryGirl.create(:transaction, description: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, description: 'no-match')
    assert_equal [t1], Transaction.search('description:MATCHING TRANSACTION')
  end
end

class TransactionCategorySearchTest < ActiveSupport::TestCase
  test 'should return the categories matching the query in alphabetical order' do
    FactoryGirl.create(:transaction, category: 'Z MATCHING')
    FactoryGirl.create(:transaction, category: 'A matching')
    FactoryGirl.create(:transaction, category: 'no-match')
    assert_equal ['A matching', 'Z MATCHING'], Transaction.category_search('matching').map(&:category)
  end
end

class TransactionDescriptionSearchTest < ActiveSupport::TestCase
  test 'should return the descriptions matching the query in alphabetical order' do
    FactoryGirl.create(:transaction, description: 'Z MATCHING')
    FactoryGirl.create(:transaction, description: 'A matching')
    FactoryGirl.create(:transaction, description: 'no-match')
    assert_equal ['A matching', 'Z MATCHING'], Transaction.description_search('matching').map(&:description)
  end
end

class TransactionPeriodTest < ActiveSupport::TestCase
  test 'should only return transactions within the given period' do
    FactoryGirl.create(:transaction, original_date: Date.parse('2011-01-01'))
    transaction = FactoryGirl.create(:transaction, original_date: Date.parse('2011-02-01'))
    FactoryGirl.create(:transaction, original_date: Date.parse('2011-03-01'))
    assert_equal [transaction], Transaction.period('2011-02')
  end

  test 'should return transactions with a date in the given period even if the original date is not' do
    FactoryGirl.create(:transaction, original_date: Date.parse('2011-01-01'))
    transaction_1 = FactoryGirl.create(:transaction, original_date: Date.parse('2011-02-01'))
    transaction_2 = FactoryGirl.create(:transaction, original_date: Date.parse('2011-03-01'), date: Date.parse('2011-02-28'))
    assert_equal [transaction_1, transaction_2].to_set, Transaction.period('2011-02').to_set
  end
end

class TransactionTest < ActiveSupport::TestCase
  test 'should always order by the most recent custom and then original date' do
    transaction_a = FactoryGirl.create(:transaction, original_date: Date.parse('2011-01-01'))
    transaction_b = FactoryGirl.create(:transaction, original_date: Date.parse('2011-01-03'))
    transaction_c = FactoryGirl.create(:transaction, original_date: Date.parse('2011-01-05'), date: Date.parse('2011-01-02'))
    assert_equal [transaction_b, transaction_c, transaction_a], Transaction.all
  end

  test 'should convert amount in pence to amount in pounds' do
    transaction = FactoryGirl.build(:transaction, amount_in_pence: 123)
    assert_equal 1.23, transaction.amount
  end

  test 'should be a debit' do
    transaction = FactoryGirl.build(:transaction, amount_in_pence: -100)
    assert transaction.debit?
  end

  test 'should be a credit' do
    transaction = FactoryGirl.build(:transaction, amount_in_pence: 100)
    assert transaction.credit?
  end
end

class TransactionDescriptionTest < ActiveSupport::TestCase
  test 'should prefer a custom description' do
    transaction = FactoryGirl.build(:transaction, description: 'custom description')
    assert_equal 'custom description', transaction.description
  end

  test 'should fall back to the original description' do
    transaction = FactoryGirl.build(:transaction, original_description: 'original description')
    assert_equal 'original description', transaction.description
  end
end

class TransactionOriginalDescriptionTest < ActiveSupport::TestCase
  test 'should build the description from the name, memo and type' do
    transaction = FactoryGirl.create(:transaction, name: 'name', memo: 'memo', type: 'other')
    assert_equal 'name / memo (other)', transaction.original_description
  end

  test 'should build the description from the name and type' do
    transaction = FactoryGirl.create(:transaction, name: 'name', memo: nil, type: 'other')
    assert_equal 'name (other)', transaction.original_description
  end
end

class TransactionDateTest < ActiveSupport::TestCase
  test 'should return the original date' do
    transaction = FactoryGirl.build(:transaction, original_date: Date.parse('2011-01-01'))
    assert_equal Date.parse('2011-01-01'), transaction.date
  end

  test 'should prefer a custom date' do
    transaction = FactoryGirl.build(:transaction, original_date: Date.parse('2011-01-01'), date: Date.parse('2011-01-02'))
    assert_equal Date.parse('2011-01-02'), transaction.date
  end
end