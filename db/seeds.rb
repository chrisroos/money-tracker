# This is the data used in the demo money tracker site, although there's nothing
# to stop you using it in development too.

unless ENV['DEMO_MODE']
  puts 'To avoid overwriting real data, seed data will only be loaded in demo mode'
  puts 'Run again with `DEMO_MODE=true` to load seed data'
  exit
end

Transaction.destroy_all
Account.destroy_all

module SeedTransaction
  ACCOUNTS = [
    Account.create!(account_id: 'personal-account', name: 'Personal account'),
    Account.create!(account_id: 'joint-account', name: 'Joint account')
  ]
  TYPES = %w(DEBIT CREDIT)
  DESCRIPTIONS = [
    'Tesco',
    'Staples',
    'The Horse and Groom',
    'Cash withdrawal',
    'The Blueberry',
    'Rent',
    nil # So that we leave some transactions 'unedited'
  ]
  CATEGORIES = [
    'Entertainment',
    nil, nil, nil # So that we leave some transactions uncategorised
  ]
  NOTES = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    nil, nil, nil # So that we leave some transactions with empty notes
  ]
  AMOUNTS = (1..10_000).to_a
  LAST_THREE_MONTHS = (3.months.ago.to_date..Date.today).to_a

  class FitId
    @fit_id = 0
    def self.next
      @fit_id += 1
    end
  end
end

150.times do
  transaction_type = SeedTransaction::TYPES.sample
  transaction_amount = SeedTransaction::AMOUNTS.sample
  transaction_amount = -transaction_amount if transaction_type == 'CREDIT'

  t = SeedTransaction::ACCOUNTS.sample.transactions.build
  t.type = transaction_type
  t.amount_in_pence = transaction_amount
  t.original_date = SeedTransaction::LAST_THREE_MONTHS.sample
  t.fit_id = SeedTransaction::FitId.next
  t.name = 'original transaction name'
  t.description = SeedTransaction::DESCRIPTIONS.sample
  t.category = SeedTransaction::CATEGORIES.sample
  t.note = SeedTransaction::NOTES.sample
  t.save!
end
