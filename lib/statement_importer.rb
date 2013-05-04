# encoding: utf-8

class StatementImporter

  def self.import(ofx)
    imported = duplicates = 0
    OFX(ofx) do
      account.transactions.each do |transaction|
        attrs = {
          original_date: transaction.posted_at, type: transaction.type,
          amount_in_pence: transaction.amount_in_pennies, fit_id: transaction.fit_id,
          name: transaction.name, memo: transaction.memo
        }
        transaction = Transaction.new
        attrs.each do |key, value|
          transaction.send "#{key}=", value
        end
        transaction.save ? imported += 1 : duplicates += 1
      end
    end
    [imported, duplicates]
  end

end