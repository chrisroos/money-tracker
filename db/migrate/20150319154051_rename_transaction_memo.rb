class RenameTransactionMemo < ActiveRecord::Migration
  def change
    rename_column :transactions, :memo, :source_memo
  end
end
