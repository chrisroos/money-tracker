FactoryGirl.define do
  sequence :account_id do |n|
    n.to_s
  end

  sequence :fit_id do |n|
    n.to_s
  end

  factory :account do
    account_id
  end

  factory :transaction do
    account
    source_date Date.today
    source_name 'transaction-source-name'
    source_amount_in_pence 1
    source_fit_id { generate(:fit_id) }
    source_type 'OTHER'
  end

  factory :upload do
    ofx_file 'ofx-file'
  end
end
