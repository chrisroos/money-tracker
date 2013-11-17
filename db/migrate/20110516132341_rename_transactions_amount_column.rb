class RenameTransactionsAmountColumn < ActiveRecord::Migration

  def self.up
    rename_column :transactions, :amount, :amount_in_pence
  end

  def self.down
    rename_column :transactions, :amount_in_pence, :amount
  end

end