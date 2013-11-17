module TransactionsHelper

  def transaction_description(transaction)
    transaction.description
  end

  def transaction_amount_in(transaction)
    number_to_currency(transaction.amount, unit: '£') if transaction.credit?
  end

  def transaction_amount_out(transaction)
    number_to_currency(-transaction.amount, unit: '£') if transaction.debit?
  end

  def transaction_income(transactions)
    income = transactions.select { |transaction| transaction.credit? }.sum(&:amount)
    number_to_currency(income, unit: '£')
  end

  def transaction_expenditure(transactions)
    expenditure = transactions.select { |transaction| transaction.debit? }.sum(&:amount)
    number_to_currency(-expenditure, unit: '£')
  end

end