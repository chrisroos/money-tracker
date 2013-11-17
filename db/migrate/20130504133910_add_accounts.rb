class AddAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, :force => true do |t|
      t.string :account_id
      t.timestamps
    end
  end
end
