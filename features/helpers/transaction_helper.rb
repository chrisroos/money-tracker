def within_transaction(description, &blk)
  transaction = Transaction.find_by_description(description) || Transaction.find_by_original_description(description)
  within "#transaction_#{transaction.id}", &blk
end

def assert_credit_transaction(amount, date, description, note = nil, category = nil)
  within_transaction(description) do
    assert_paid_in     amount
    assert_transaction date, description, note, category
  end
end

def assert_debit_transaction(amount, date, description, note = nil, category = nil)
  xpath_transaction = "*[@class='transaction']"
  xpath_paid_out    = "*[@class='paid_out'][contains(text(), '#{amount}')]"
  xpath_description = "*[@class='description']/a[contains(text(), '#{description}')]"
  xpath_date        = "*[contains(@class, 'date')][contains(text(), '#{Date.parse(date).to_s(:weekday_and_day)}')]"
  xpath_note        = "*[@class='note'][contains(text(), '#{note}')]"
  xpath_category    = "*[@class='category']/a[contains(text(), '#{category}')]"
  xpath = "//#{xpath_transaction}//#{xpath_paid_out}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_description}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_date}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_note}" if note
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_category}" if category

  assert page.has_xpath?(xpath)
end

def assert_transaction(date, description, note = nil, category = nil)
  assert_date(date)
  assert_description(description)
  assert_note(note)         if note
  assert_category(category) if category
end

def assert_paid_in(amount)
  assert page.has_css?('.paid_in', :text => amount)
end

def assert_paid_out(amount)
  assert page.has_css?('.paid_out', :text => amount)
end

def assert_date(date)
  assert page.has_css?('.date', :text => Date.parse(date).to_s(:weekday_and_day))
end

def assert_description(description)
  assert page.has_css?('.description', :text => description)
end

def assert_note(note)
  assert page.has_css?('.note', :text => note)
end

def assert_category(category)
  assert page.has_css?('.category', :text => category)
end