Factory.define :transaction do |transaction|
  transaction.datetime    Time.now
  transaction.description 'transaction-description'
end