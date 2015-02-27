class AddTransactionCategories < ActiveRecord::Migration
  def self.up
    add_column :transactions, :category, :string
  end

  def self.down
    remove_column :transactions, :category
  end
end
