class AddTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.datetime :datetime
      t.string :description
      t.text :note
    end
  end

  def self.down
    drop_table :transactions
  end
end
