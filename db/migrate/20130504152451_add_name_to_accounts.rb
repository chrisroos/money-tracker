class AddNameToAccounts < ActiveRecord::Migration
  class Account < ActiveRecord::Base; end

  def change
    add_column :accounts, :name, :string
    Account.reset_column_information
  end
end
