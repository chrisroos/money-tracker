class AddAmountToTransactions < ActiveRecord::Migration

  def self.up
    add_column :transactions, :amount, :integer
  end

  def self.down
    remove_column :transactions, :amount
  end

end
