class AddOriginalDateToTransactions < ActiveRecord::Migration

  def self.up
    rename_column :transactions, :date, :original_date
    add_column :transactions, :date, :date
  end

  def self.down
    remove_column :transactions, :date
    rename_column :transactions, :original_date, :date
  end

end
