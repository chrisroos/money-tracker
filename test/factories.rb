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
    original_date   Date.today
    name            'transaction-name'
    amount_in_pence 1
    fit_id
    type            'OTHER'
  end

  factory :upload do
    ofx_file 'ofx-file'
  end
end