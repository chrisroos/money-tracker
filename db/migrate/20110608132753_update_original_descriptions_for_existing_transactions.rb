class UpdateOriginalDescriptionsForExistingTransactions < ActiveRecord::Migration
  def self.up
    Transaction.find_each(conditions: {original_description: nil}) do |transaction|
      transaction.send :set_original_description
      transaction.save!
    end
  end

  def self.down
    # Intentionally blank
  end
end
