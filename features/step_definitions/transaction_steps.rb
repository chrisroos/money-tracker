Then /^I should see the following transactions:$/ do |expected_transactions_table|
  expected_transactions_table.diff!(tableish('table tr', 'td,th'))
end