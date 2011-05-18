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
  
end