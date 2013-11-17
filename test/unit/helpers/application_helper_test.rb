require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#link_to_location returns nil if the transactions's location is missing" do
    transaction = FactoryGirl.build(:transaction, location: nil)
    assert_nil link_to_location(transaction)
  end

  test '#link_to_location links to google maps using the map icon' do
    transaction = FactoryGirl.build(:transaction, location: 'London EC2A')

    render text: link_to_location(transaction)

    assert_select 'a i.icon-map-marker'
    assert_select 'a[href=?]', 'https://maps.google.co.uk/maps?q=London+EC2A'
  end
end