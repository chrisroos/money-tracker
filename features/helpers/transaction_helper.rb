def assert_credit_transaction(amount, date, description)
  transaction = Transaction.find_by_description(description)
  within "#transaction_#{transaction.id}" do
    assert page.has_css?('.paid_in', :text => amount)
    assert page.has_css?('.date', :text => Date.parse(date).to_s(:weekday_and_day))
    assert page.has_css?('.description', :text => description)
  end
end

def assert_debit_transaction(amount, date, description)
  transaction = Transaction.find_by_description(description)
  within "#transaction_#{transaction.id}" do
    assert page.has_css?('.paid_out', :text => amount)
    assert page.has_css?('.date', :text => Date.parse(date).to_s(:weekday_and_day))
    assert page.has_css?('.description', :text => description)
  end
end