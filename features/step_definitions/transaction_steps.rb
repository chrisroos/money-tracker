Given /^the following transactions:$/ do |transactions|
  Transaction.create!(transactions.hashes)
end

Then /^I should see the following transactions:$/ do |expected_transactions_table|
  expected_transactions_table.diff!(tableish('table tr', 'td,th'))
end