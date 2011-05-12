class StatementImporter
  
  def self.import(ofx)
    OFX(ofx) do
      account.transactions.each do |transaction|
        attrs = {
          :date => transaction.posted_at, :ofx_type => transaction.type, 
          :amount => transaction.amount_in_pennies, :fit_id => transaction.fit_id, 
          :name => transaction.name, :memo => transaction.memo
        }
        Transaction.create! attrs
      end
    end
  end
  
end