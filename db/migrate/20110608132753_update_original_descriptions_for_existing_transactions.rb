class UpdateOriginalDescriptionsForExistingTransactions < ActiveRecord::Migration
  def self.up
    Transaction.where(original_description: nil).find_each do |transaction|
      transaction.send :set_original_description
      transaction.save!
    end
  end

  def self.down
    # Intentionally blank
  end
end
