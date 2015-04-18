require 'test_helper'

class GroupingTest < ActiveSupport::TestCase
  test 'should return an array of groupings' do
    query = 'query-string'
    Transaction.stubs(:grouping_search).with(query).returns([stub(grouping: 'grouping-name')])
    assert_equal ['grouping-name'], Grouping.search(query)
  end
end
