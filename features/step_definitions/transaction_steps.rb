Then(/^I should see that the income of the transactions is £(\d+)$/) do |income|
  assert page.has_css?('#income', text: "£#{income}")
end

Then(/^I should see that the expenditure of the transactions is £(\d+)$/) do |expenditure|
  assert page.has_css?('#expenditure', text: "£#{expenditure}")
end

Then(/^I should see a credit of £(\d+\.\d+) on (\d{4}\-\d{2}\-\d{2}) described as "([^"]*)"$/) do |amount, date, description|
  assert_credit_transaction amount, date, description
end

Then(/^I should see a debit of £(\d+\.\d+) on (\d{4}\-\d{2}\-\d{2}) described as "([^"]*)"$/) do |amount, date, description|
  assert_debit_transaction amount, date, description
end

Then(/^I should see a debit of £(\d+\.\d+) on (\d{4}\-\d{2}\-\d{2}) described as "([^"]*)" in the "([^"]*)" category$/) do |amount, date, description, category|
  assert_debit_transaction amount, date, description, nil, category
end

Then(/^I should see a credit of £(\d+\.\d+) on (\d{4}\-\d{2}\-\d{2}) described as "([^"]*)" with a note of "([^"]*)" in the "([^"]*)" category$/) do |amount, date, description, note, category|
  assert_credit_transaction amount, date, description, note, category
end

Then(/^I should see a debit of £(\d+\.\d+) on (\d{4}\-\d{2}\-\d{2}) described as "([^"]*)" with a note of "([^"]*)" in the "([^"]*)" category$/) do |amount, date, description, note, category|
  assert_debit_transaction amount, date, description, note, category
end