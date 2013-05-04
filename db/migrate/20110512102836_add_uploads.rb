# encoding: utf-8

class AddUploads < ActiveRecord::Migration

  def self.up
    create_table :uploads, force: true do |t|
      t.string :ofx_file
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end

end