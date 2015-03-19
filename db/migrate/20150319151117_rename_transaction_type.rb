class RenameTransactionType < ActiveRecord::Migration
  def change
    rename_column :transactions, :type, :source_type
  end
end
