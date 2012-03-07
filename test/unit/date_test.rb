require 'test_helper'

class DateTest < ActiveSupport::TestCase

  should "create a date from a period" do
    assert_equal Date.parse('2011-01-01'), Date.from_period('2011-01')
  end

end