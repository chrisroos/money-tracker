require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'should return an array of locations for the given description' do
    description = 'description'
    query = 'query-string'
    Transaction.stubs(:location_search).with(description, query).returns([stub(location: 'location-name')])
    assert_equal ['location-name'], Location.search(description, query)
  end

  test 'should exclude empty locations' do
    transactions = [stub(location: 'location-name'), stub(location: '')]
    Transaction.stubs(:location_search).returns(transactions)
    assert_equal ['location-name'], Location.search('', '')
  end
end
