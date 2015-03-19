class RenameTransactionOriginalDate < ActiveRecord::Migration
  def change
    rename_column :transactions, :original_date, :source_date
  end
end
