Then /^I should see the following transactions:$/ do |expected_transactions_table|
  expected_transactions_table.diff!(tableish('table tr', 'td,th'))
end

Then /^I should see that my monthly income was £(\d+)$/ do |income|
  assert page.has_css?('#income', :text => "£#{income}")
end

Then /^I should see that my monthly expenditure was £(\d+)$/ do |expenditure|
  assert page.has_css?('#expenditure', :text => "£#{expenditure}")
end