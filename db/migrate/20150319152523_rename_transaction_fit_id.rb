class RenameTransactionFitId < ActiveRecord::Migration
  def change
    rename_column :transactions, :fit_id, :source_fit_id
  end
end
