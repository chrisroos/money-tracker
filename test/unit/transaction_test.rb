require 'test_helper'

class TransactionValidationTest < ActiveSupport::TestCase

  should "be valid when build from the factory" do
    transaction = Factory.build(:transaction)
    assert transaction.valid?
  end
  
  should "be invalid without a datetime" do
    transaction = Factory.build(:transaction, :date => nil)
    assert ! transaction.valid?
  end
  
  should "be invalid without a name" do
    transaction = Factory.build(:transaction, :name => nil)
    assert ! transaction.valid?
  end
  
  should "be invalid without an amount in pence" do
    transaction = Factory.build(:transaction, :amount_in_pence => nil)
    assert ! transaction.valid?
  end
  
  should "be invalid without an ofx type" do
    transaction = Factory.build(:transaction, :type => nil)
    assert ! transaction.valid?
  end
  
  should "be invalid without a fit_id" do
    transaction = Factory.build(:transaction, :fit_id => nil)
    assert ! transaction.valid?
  end
  
  should "be invalid unless the fit_id is unique" do
    Factory.create(:transaction, :fit_id => '123')
    assert_raise(ActiveRecord::RecordInvalid) { Factory.create(:transaction, :fit_id => '123') }
  end
  
end

class TransactionSearchTest < ActiveSupport::TestCase
  
  should "search Transaction#name" do
    t1 = Factory.create(:transaction, :name => 'MATCHING TRANSACTION')
    t2 = Factory.create(:transaction, :name => 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end
  
  should "search Transaction#memo" do
    t1 = Factory.create(:transaction, :memo => 'MATCHING TRANSACTION')
    t2 = Factory.create(:transaction, :memo => 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end
  
  should "search Transaction#note" do
    t1 = Factory.create(:transaction, :note => 'MATCHING TRANSACTION')
    t2 = Factory.create(:transaction, :note => 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end
  
  should "search Transaction#type" do
    t1 = Factory.create(:transaction, :type => 'MATCHING TRANSACTION')
    t2 = Factory.create(:transaction, :type => 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end
  
  should "search Transaction#description" do
    t1 = Factory.create(:transaction, :description => 'MATCHING TRANSACTION')
    t2 = Factory.create(:transaction, :description => 'no-match')
    assert_equal [t1], Transaction.search('matching')
  end
  
end

class TransactionTest < ActiveSupport::TestCase
  
  should "always order by the most recent date" do
    old_transaction = Factory.create(:transaction, :date => Date.parse('2010-01-01'))
    new_transaction = Factory.create(:transaction, :date => Date.parse('2011-01-01'))
    assert_equal [new_transaction, old_transaction], Transaction.all
  end
  
  should "convert amount in pence to amount in pounds" do
    transaction = Factory.build(:transaction, :amount_in_pence => 123)
    assert_equal 1.23, transaction.amount
  end
  
end

class TransactionDescriptionTest < ActiveSupport::TestCase
  
  should "build the description from the name, memo and type" do
    transaction = Factory.build(:transaction, :name => 'name', :memo => 'memo', :type => 'other')
    assert_equal 'name / memo (other)', transaction.description
  end
  
  should "build the description from the name and type" do
    transaction = Factory.build(:transaction, :name => 'name', :memo => nil, :type => 'other')
    assert_equal 'name (other)', transaction.description
  end
  
  should "prefer a custom description" do
    transaction = Factory.build(:transaction, :description => 'custom description')
    assert_equal 'custom description', transaction.description
  end
  
end