class Transaction < ActiveRecord::Base
  
  default_scope order('date DESC')
  
  scope :search, lambda { |search_string| 
    where(
      'name LIKE :q OR memo LIKE :q OR note LIKE :q', 
      {:q => "%#{search_string}%"}
    )
  }
  
  validates_presence_of :date, :name, :amount, :fit_id
  validates_uniqueness_of :fit_id
  
end