# encoding: utf-8

class ChangeTransactionDatetimeToDate < ActiveRecord::Migration
  
  def self.up
    change_column :transactions, :datetime, :date
    rename_column :transactions, :datetime, :date
  end

  def self.down
    rename_column :transactions, :date, :datetime
    change_column :transactions, :datetime, :datetime
  end
  
end