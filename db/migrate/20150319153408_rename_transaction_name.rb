class RenameTransactionName < ActiveRecord::Migration
  def change
    rename_column :transactions, :name, :source_name
  end
end
