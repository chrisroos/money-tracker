# encoding: utf-8

# This is the data used in the demo money tracker site, although there's nothing
# to stop you using it in development too.

unless ENV['DEMO_MODE']
  puts "To avoid overwriting real data, seed data will only be loaded in demo mode"
  exit
end

Transaction.destroy_all
Account.destroy_all

module SeedTransaction
  Accounts = [
    Account.create!(account_id: 'personal-account', name: 'Personal account'),
    Account.create!(account_id: 'joint-account', name: 'Joint account')
  ]
  Types = [
    'DEBIT',
    'CREDIT'
  ]
  Descriptions = [
    'Tesco',
    'Staples',
    'The Horse and Groom',
    'Cash withdrawal',
    'The Blueberry',
    'Rent',
    nil # So that we leave some transactions 'unedited'
  ]
  Categories = [
    'Entertainment',
    nil, nil, nil # So that we leave some transactions uncategorised
  ]
  Notes = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    nil, nil, nil # So that we leave some transactions with empty notes
  ]
  Amounts = (1..10000).to_a
  LastThreeMonths = (3.months.ago.to_date..Date.today).to_a

  class FitId
    @fit_id = 0
    def self.next
      @fit_id += 1
    end
  end
end

150.times do
  transaction_type = SeedTransaction::Types.sample
  transaction_amount = SeedTransaction::Amounts.sample
  transaction_amount = -transaction_amount if transaction_type == 'CREDIT'

  t = SeedTransaction::Accounts.sample.transactions.build
  t.type = transaction_type
  t.amount_in_pence = transaction_amount
  t.original_date = SeedTransaction::LastThreeMonths.sample
  t.fit_id = SeedTransaction::FitId.next
  t.name = 'original transaction name'
  t.description = SeedTransaction::Descriptions.sample
  t.category = SeedTransaction::Categories.sample
  t.note = SeedTransaction::Notes.sample
  t.save!
end
