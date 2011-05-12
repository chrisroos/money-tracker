class Transaction < ActiveRecord::Base
  validates_presence_of :date, :name, :amount
  validates_uniqueness_of :fit_id
end