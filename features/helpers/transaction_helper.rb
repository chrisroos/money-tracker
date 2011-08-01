def assert_credit_transaction(amount, date, description, note = nil, category = nil)
  xpath_transaction = "*[@class='transaction']"
  xpath_paid_out    = "*[@class='paid_in'][contains(text(), '#{amount}')]"
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