class LinkTransactionsToAccounts < ActiveRecord::Migration
  class Account < ActiveRecord::Base; end

  def change
    add_column :transactions, :account_id, :integer
    account = Account.create! account_id: 'generated-by-migration'
    update "UPDATE transactions SET account_id = #{account.id}"
    change_column :transactions, :account_id, :integer, null: false
  end
end
