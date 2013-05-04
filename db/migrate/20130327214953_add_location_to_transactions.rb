# encoding: utf-8

class AddLocationToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :location, :string
  end
end