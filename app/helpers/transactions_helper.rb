module TransactionsHelper
  
  def transaction_description(transaction)
    transaction.description.titleize
  end
  
  def transaction_amount_in(transaction)
    number_to_currency(transaction.amount, :unit => '£') if transaction.amount > 0
  end
  
  def transaction_amount_out(transaction)
    number_to_currency(-transaction.amount, :unit => '£') if transaction.amount < 0
  end
  
  def transaction_income(transactions)
    income = transactions.select { |transaction| transaction.amount > 0 }.inject(0) { |total, transaction| total + transaction.amount }
    number_to_currency(income, :unit => '£')
  end
  
  def transaction_expenditure(transactions)
    expenditure = transactions.select { |transaction| transaction.amount < 0 }.inject(0) { |total, transaction| total + transaction.amount }
    number_to_currency(-expenditure, :unit => '£')
  end
  
end