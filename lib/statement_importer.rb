class StatementImporter
  def self.import(ofx)
    imported = duplicates = 0
    OFX(ofx) do
      target_account = Account.find_by_account_id(account.id) || Account.create!(account_id: account.id)
      account.transactions.each do |transaction|
        attrs = {
          source_date: transaction.posted_at, source_type: transaction.type,
          source_amount_in_pence: transaction.amount_in_pennies, source_fit_id: transaction.fit_id,
          source_name: transaction.name, source_memo: transaction.memo
        }
        transaction = target_account.transactions.build
        attrs.each do |key, value|
          transaction.send "#{key}=", value
        end
        transaction.save ? imported += 1 : duplicates += 1
      end
    end
    [imported, duplicates]
  end
end
