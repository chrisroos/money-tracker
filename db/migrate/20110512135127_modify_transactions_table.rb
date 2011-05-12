class ModifyTransactionsTable < ActiveRecord::Migration
  
  def self.up
    rename_column :transactions, :description, :name
    
    add_column :transactions, :ofx_type, :string
    add_column :transactions, :fit_id,   :string
    add_column :transactions, :memo,     :string
  end

  def self.down
    remove_column :transactions, :memo
    remove_column :transactions, :fit_id
    remove_column :transactions, :ofx_type
    
    rename_column :transactions, :name, :description
  end
  
end