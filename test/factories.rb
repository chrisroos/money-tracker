Factory.define :transaction do |transaction|
  transaction.date   Date.today
  transaction.name   'transaction-name'
  transaction.amount 1
end