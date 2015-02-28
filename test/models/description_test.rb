require 'test_helper'

class DescriptionTest < ActiveSupport::TestCase
  test 'should return an array of descriptions' do
    query = 'query-string'
    Transaction.stubs(:description_search).with(query).returns([stub(description: 'description-name')])
    assert_equal ['description-name'], Description.search(query)
  end
end
