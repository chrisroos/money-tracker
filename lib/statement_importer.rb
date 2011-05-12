class StatementImporter
  
  def self.import(ofx)
    duplicates = 0
    OFX(ofx) do
      account.transactions.each do |transaction|
        attrs = {
          :date => transaction.posted_at, :ofx_type => transaction.type, 
          :amount => transaction.amount_in_pennies, :fit_id => transaction.fit_id, 
          :name => transaction.name, :memo => transaction.memo
        }
        transaction = Transaction.new(attrs)
        unless transaction.save
          duplicates += 1
        end
      end
    end
    duplicates
  end
  
end