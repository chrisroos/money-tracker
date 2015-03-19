require 'test_helper'

class StatementImporterTest < ActiveSupport::TestCase
  test 'should add the transactions to the account matching the account_id in the ofx file' do
    account = FactoryGirl.create(:account, account_id: '12341234123412')
    StatementImporter.import(example_ofx)
    assert_equal [account], Transaction.all.map(&:account).uniq
  end

  test "should add the transactions to a new account if we don't have an account matching the account_id in the ofx file" do
    assert_nil Account.find_by_account_id('12341234123412')

    StatementImporter.import(example_ofx)

    account = Account.find_by_account_id!('12341234123412')
    assert_equal [account], Transaction.all.map(&:account).uniq
  end

  test 'should import two transactions' do
    StatementImporter.import(example_ofx)
    assert_equal 2, Transaction.count
  end

  test 'should import the first transaction' do
    StatementImporter.import(example_ofx)

    transaction = Transaction.find_by_fit_id('2011010112345678901234567890123')
    assert_equal Date.parse('2011-01-01'), transaction.source_date
    assert_equal 'other',                  transaction.source_type
    assert_equal(-123,                     transaction.source_amount_in_pence)
    assert_equal 'SHOP X',                 transaction.name
    assert_equal 'LONDON',                 transaction.memo
  end

  test 'should import the second transaction' do
    StatementImporter.import(example_ofx)

    transaction = Transaction.find_by_fit_id('2011010212345678901234567890123')
    assert_equal Date.parse('2011-01-02'), transaction.source_date
    assert_equal 'other',                  transaction.source_type
    assert_equal 321,                      transaction.source_amount_in_pence
    assert_equal 'WAGES',                  transaction.name
    assert_equal 'ACME LTD',               transaction.memo
  end

  private

  def example_ofx
    File.read(Rails.root.join('test/fixtures/example-statement.ofx'))
  end
end
