class Transaction < ActiveRecord::Base
  
  default_scope order('date DESC')
  
  validates_presence_of :date, :name, :amount, :fit_id
  validates_uniqueness_of :fit_id
  
end