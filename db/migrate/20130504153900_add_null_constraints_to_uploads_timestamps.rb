class AddNullConstraintsToUploadsTimestamps < ActiveRecord::Migration
  def change
    change_column :uploads, :created_at, :datetime, null: false
    change_column :uploads, :updated_at, :datetime, null: false
  end
end
