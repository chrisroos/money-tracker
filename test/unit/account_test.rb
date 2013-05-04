require 'test_helper'

class AccountValidationTest < ActiveSupport::TestCase
  test 'should be valid when build from the factory' do
    account = FactoryGirl.build(:account)
    assert account.valid?
  end

  test 'should be invalid without an account id' do
    account = FactoryGirl.build(:account, account_id: nil)
    assert !account.valid?
  end

  test 'should be invalid unless the account_id is unique' do
    FactoryGirl.create(:account, account_id: '123')
    assert_raise(ActiveRecord::RecordInvalid) { FactoryGirl.create(:account, account_id: '123') }
  end
end