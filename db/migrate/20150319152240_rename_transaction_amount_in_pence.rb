class RenameTransactionAmountInPence < ActiveRecord::Migration
  def change
    rename_column :transactions, :amount_in_pence, :source_amount_in_pence
  end
end
