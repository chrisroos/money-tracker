class AddLocationToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :location, :string
  end
end