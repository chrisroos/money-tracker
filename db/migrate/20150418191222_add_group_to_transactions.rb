class AddGroupToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :grouping, :string
  end
end
