require 'csv'

account_name = ARGV.shift
unless account_name && (account = Account.find_by_name(account_name))
  puts "Usage: #{File.basename(__FILE__)} <account-name>"
  exit 1
end

csv_filename = Rails.root.join('tmp', 'transactions.csv')

File.open(csv_filename, 'w') do |file|
  account.transactions.each do |transaction|
    file.puts([transaction.date, transaction.description, transaction.location, transaction.note, transaction.amount].to_csv)
  end
end

puts "CSV written to #{csv_filename}"
