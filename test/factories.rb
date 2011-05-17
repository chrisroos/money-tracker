Factory.sequence :fit_id do |n|
  n.to_s
end

Factory.define :transaction do |transaction|
  transaction.original_date   Date.today
  transaction.name            'transaction-name'
  transaction.amount_in_pence 1
  transaction.fit_id          { Factory.next(:fit_id) }
  transaction.type            'OTHER'
end

Factory.define :upload do |upload|
  upload.ofx_file 'ofx-file'
end