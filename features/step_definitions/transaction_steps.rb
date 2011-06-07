Then /^I should see the following transactions:$/ do |expected_transactions_table|
  expected_transactions_table.diff!(tableish('table tr', 'td,th'), :surplus_row => false)
end

Then /^I should see that the income of the transactions is £(\d+)$/ do |income|
  assert page.has_css?('#income', :text => "£#{income}")
end

Then /^I should see that the expenditure of the transactions is £(\d+)$/ do |expenditure|
  assert page.has_css?('#expenditure', :text => "£#{expenditure}")
end