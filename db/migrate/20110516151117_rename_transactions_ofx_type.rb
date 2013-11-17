class RenameTransactionsOfxType < ActiveRecord::Migration

  def self.up
    rename_column :transactions, :ofx_type, :type
  end

  def self.down
    rename_column :transactions, :type, :ofx_type
  end

end
