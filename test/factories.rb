FactoryGirl.define do
  sequence :fit_id do |n|
    n.to_s
  end

  factory :transaction do
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