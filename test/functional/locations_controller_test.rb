require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  test 'should render the search results as json' do
    Location.stubs(:search).with('description', 'search-term').returns(['result-1', 'result-2'])
    get :search, description: 'description', term: 'search-term'
    assert_equal ['result-1', 'result-2'], ActiveSupport::JSON.decode(response.body)
  end
end
