Factory.define :transaction do |transaction|
  transaction.date        Date.today
  transaction.description 'transaction-description'
  transaction.amount      1
end