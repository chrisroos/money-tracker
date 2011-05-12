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
  
  should "be invalid without a description" do
    transaction = Factory.build(:transaction)
    transaction.description = nil
    assert ! transaction.valid?
  end
  
end
