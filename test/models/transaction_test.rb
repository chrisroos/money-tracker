require 'test_helper'

class TransactionValidationTest < ActiveSupport::TestCase
  test 'should be valid when build from the factory' do
    transaction = FactoryGirl.build(:transaction)
    assert transaction.valid?
  end

  test 'should be invalid without an account_id' do
    transaction = FactoryGirl.build(:transaction, account_id: nil)
    assert !transaction.valid?
  end

  test 'should be invalid without an original date' do
    transaction = FactoryGirl.build(:transaction, source_date: nil)
    assert !transaction.valid?
  end

  test 'should be invalid without a source_name' do
    transaction = FactoryGirl.build(:transaction, source_name: nil)
    assert !transaction.valid?
  end

  test 'should be invalid without an amount in pence' do
    transaction = FactoryGirl.build(:transaction, source_amount_in_pence: nil)
    assert !transaction.valid?
  end

  test 'should be invalid without a source_type' do
    transaction = FactoryGirl.build(:transaction, source_type: nil)
    assert !transaction.valid?
  end

  test 'should be invalid without an original description' do
    transaction = FactoryGirl.create(:transaction)
    transaction.original_description = nil
    assert !transaction.valid?
  end

  test 'should be invalid without a fit_id' do
    transaction = FactoryGirl.build(:transaction, source_fit_id: nil)
    assert !transaction.valid?
  end

  test 'should be invalid unless the fit_id is unique' do
    FactoryGirl.create(:transaction, source_fit_id: '123')
    assert_raise(ActiveRecord::RecordInvalid) { FactoryGirl.create(:transaction, source_fit_id: '123') }
  end
end

class TransactionSearchTest < ActiveSupport::TestCase
  test 'should search Transaction#source_name' do
    t1 = FactoryGirl.create(:transaction, source_name: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, source_name: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#source_memo' do
    t1 = FactoryGirl.create(:transaction, source_memo: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, source_memo: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#note' do
    t1 = FactoryGirl.create(:transaction, note: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, note: 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end

  test 'should search Transaction#source_type' do
    t1 = FactoryGirl.create(:transaction, source_type: 'MATCHING TRANSACTION')
    FactoryGirl.create(:transaction, source_type: 'no-match')
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

class TransactionLocationSearchTest < ActiveSupport::TestCase
  test 'should only return the locations matching the description _and_ query in alphabetical order' do
    FactoryGirl.create(:transaction, description: 'description-a', location: 'Z MATCHING')
    FactoryGirl.create(:transaction, description: 'description-a', location: 'no-match')
    FactoryGirl.create(:transaction, description: 'description-a', location: 'A matching')
    FactoryGirl.create(:transaction, description: 'description-z', location: 'matching for different description')
    assert_equal ['A matching', 'Z MATCHING'], Transaction.location_search('description-a', 'matching').map(&:location)
  end

  test 'should ignore the case of the description when searching for locations' do
    FactoryGirl.create(:transaction, description: 'description-a', location: 'matching-a')
    FactoryGirl.create(:transaction, description: 'DESCRIPTION-A', location: 'matching-b')
    assert_equal ['matching-a', 'matching-b'], Transaction.location_search('description-a', 'matching').map(&:location)
  end
end

class TransactionGroupSearchTest < ActiveSupport::TestCase
  test 'should return the groupings matching the query in alphabetical order' do
    FactoryGirl.create(:transaction, grouping: 'Z MATCHING')
    FactoryGirl.create(:transaction, grouping: 'A matching')
    FactoryGirl.create(:transaction, grouping: 'no-match')
    assert_equal ['A matching', 'Z MATCHING'], Transaction.grouping_search('matching').map(&:grouping)
  end
end

class TransactionPeriodTest < ActiveSupport::TestCase
  test 'should only return transactions within the given period' do
    FactoryGirl.create(:transaction, source_date: Date.parse('2011-01-01'))
    transaction = FactoryGirl.create(:transaction, source_date: Date.parse('2011-02-01'))
    FactoryGirl.create(:transaction, source_date: Date.parse('2011-03-01'))
    assert_equal [transaction], Transaction.period('2011-02')
  end

  test 'should return transactions with a date in the given period even if the original date is not' do
    FactoryGirl.create(:transaction, source_date: Date.parse('2011-01-01'))
    transaction_1 = FactoryGirl.create(:transaction, source_date: Date.parse('2011-02-01'))
    transaction_2 = FactoryGirl.create(:transaction, source_date: Date.parse('2011-03-01'), date: Date.parse('2011-02-28'))
    assert_equal [transaction_1, transaction_2].to_set, Transaction.period('2011-02').to_set
  end
end

class TransactionTest < ActiveSupport::TestCase
  test 'should always order by the most recent custom and then original date' do
    transaction_a = FactoryGirl.create(:transaction, source_date: Date.parse('2011-01-01'))
    transaction_b = FactoryGirl.create(:transaction, source_date: Date.parse('2011-01-03'))
    transaction_c = FactoryGirl.create(:transaction, source_date: Date.parse('2011-01-05'), date: Date.parse('2011-01-02'))
    assert_equal [transaction_b, transaction_c, transaction_a], Transaction.all
  end

  test 'should convert amount in pence to amount in pounds' do
    transaction = FactoryGirl.build(:transaction, source_amount_in_pence: 123)
    assert_equal 1.23, transaction.amount
  end

  test 'should be a debit' do
    transaction = FactoryGirl.build(:transaction, source_amount_in_pence: -100)
    assert transaction.debit?
  end

  test 'should be a credit' do
    transaction = FactoryGirl.build(:transaction, source_amount_in_pence: 100)
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
  test 'should build the description from the source_name, source_memo and source_type' do
    transaction = FactoryGirl.create(:transaction, source_name: 'source-name', source_memo: 'source-memo', source_type: 'other')
    assert_equal 'source-name / source-memo (other)', transaction.original_description
  end

  test 'should build the description from the source_name and source_type' do
    transaction = FactoryGirl.create(:transaction, source_name: 'source-name', source_memo: nil, source_type: 'other')
    assert_equal 'source-name (other)', transaction.original_description
  end
end

class TransactionDateTest < ActiveSupport::TestCase
  test 'should return the original date' do
    transaction = FactoryGirl.build(:transaction, source_date: Date.parse('2011-01-01'))
    assert_equal Date.parse('2011-01-01'), transaction.date
  end

  test 'should prefer a custom date' do
    transaction = FactoryGirl.build(:transaction, source_date: Date.parse('2011-01-01'), date: Date.parse('2011-01-02'))
    assert_equal Date.parse('2011-01-02'), transaction.date
  end
end
