# encoding: utf-8

class AddOriginalDescriptionToTransactions < ActiveRecord::Migration
  
  def self.up
    add_column :transactions, :original_description, :string
  end

  def self.down
    remove_column :transactions, :original_description
  end
  
end