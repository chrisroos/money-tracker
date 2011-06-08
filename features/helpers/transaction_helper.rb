def assert_credit_transaction(amount, date, description, note = nil, category = nil)
  within_transaction(description) do
    assert page.has_css?('.paid_in', :text => amount)
    assert page.has_css?('.date', :text => Date.parse(date).to_s(:weekday_and_day))
    assert page.has_css?('.description', :text => description)
    assert page.has_css?('.note', :text => note) if note
    assert page.has_css?('.category', :text => category) if category
  end
end

def assert_debit_transaction(amount, date, description, note = nil, category = nil)
  within_transaction(description) do
    assert page.has_css?('.paid_out', :text => amount)
    assert page.has_css?('.date', :text => Date.parse(date).to_s(:weekday_and_day))
    assert page.has_css?('.description', :text => description)
    assert page.has_css?('.note', :text => note) if note
    assert page.has_css?('.category', :text => category) if category
  end
end

def within_transaction(description, &blk)
  transaction = Transaction.find_by_description(description) || Transaction.find_by_original_description(description)
  within "#transaction_#{transaction.id}", &blk
end