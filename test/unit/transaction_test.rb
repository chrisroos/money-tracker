require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  should "be valid when build from the factory" do
    transaction = Factory.build(:transaction)
    assert transaction.valid?
  end
  
  should "be invalid without a datetime" do
    transaction = Factory.build(:transaction)
    transaction.date = nil
    assert ! transaction.valid?
  end
  
  should "be invalid without a name" do
    transaction = Factory.build(:transaction)
    transaction.name = nil
    assert ! transaction.valid?
  end
  
  should "be invalid without an amount" do
    transaction = Factory.build(:transaction)
    transaction.amount = nil
    assert ! transaction.valid?
  end
  
  should "be invalid without a fit_id" do
    transaction = Factory.build(:transaction)
    transaction.fit_id = nil
    assert ! transaction.valid?
  end
  
  should "be invalid unless the fit_id is unique" do
    Factory.create(:transaction, :fit_id => '123')
    assert_raise(ActiveRecord::RecordInvalid) { Factory.create(:transaction, :fit_id => '123') }
  end
  
  should "always order by the most recent date" do
    old_transaction = Factory.create(:transaction, :date => Date.parse('2010-01-01'))
    new_transaction = Factory.create(:transaction, :date => Date.parse('2011-01-01'))
    assert_equal [new_transaction, old_transaction], Transaction.all
  end
  
end
