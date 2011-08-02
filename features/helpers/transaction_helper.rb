def assert_credit_transaction(amount, date, description, note = nil, category = nil)
  xpath = "//#{xpath_transaction}//#{xpath_paid_in(amount)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_description(description)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_date(date)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_note(note)}" if note
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_category(category)}" if category

  assert page.has_xpath?(xpath)
end

def assert_debit_transaction(amount, date, description, note = nil, category = nil)
  xpath = "//#{xpath_transaction}//#{xpath_paid_out(amount)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_description(description)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_date(date)}"
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_note(note)}" if note
  xpath += "/ancestor::#{xpath_transaction}//#{xpath_category(category)}" if category

  assert page.has_xpath?(xpath)
end

def xpath_transaction
  "*[@class='transaction']"
end

def xpath_paid_in(amount)
  "*[@class='paid_in'][contains(text(), '#{amount}')]"
end

def xpath_paid_out(amount)
  "*[@class='paid_out'][contains(text(), '#{amount}')]"
end

def xpath_description(description)
  "*[@class='description'][contains(text(), '#{description}')]"
end

def xpath_date(date)
  "*[contains(@class, 'date')][contains(text(), '#{Date.parse(date).to_s(:weekday_and_day)}')]"
end

def xpath_note(note)
  "*[@class='note'][contains(text(), '#{note}')]"
end

def xpath_category(category)
  "*[@class='category'][contains(text(), '#{category}')]"
end