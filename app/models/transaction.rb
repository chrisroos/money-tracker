class Transaction < ActiveRecord::Base
  validates_presence_of :date, :name, :amount
end