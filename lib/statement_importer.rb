class StatementImporter
  
  def self.import(ofx)
    imported = duplicates = 0
    OFX(ofx) do
      account.transactions.each do |transaction|
        attrs = {
          :date => transaction.posted_at, :ofx_type => transaction.type, 
          :amount_in_pence => transaction.amount_in_pennies, :fit_id => transaction.fit_id, 
          :name => transaction.name, :memo => transaction.memo
        }
        transaction = Transaction.new(attrs)
        transaction.save ? imported += 1 : duplicates += 1
      end
    end
    [imported, duplicates]
  end
  
end