# encoding: utf-8
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should return an array of categories' do
    query = 'query-string'
    Transaction.stubs(:category_search).with(query).returns([stub(category: 'category-name')])
    assert_equal ['category-name'], Category.search(query)
  end
end