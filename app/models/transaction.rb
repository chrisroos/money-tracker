class Transaction < ActiveRecord::Base
  validates_presence_of :date, :description
end