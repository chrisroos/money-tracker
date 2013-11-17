class AddDescriptionToTransactions < ActiveRecord::Migration

  def self.up
    add_column :transactions, :description, :string
  end

  def self.down
    remove_column :transactions, :description
  end

end
