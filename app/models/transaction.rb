class Transaction < ActiveRecord::Base
  
  set_inheritance_column :_disabled_sti
  
  default_scope order('date DESC')
  
  scope :search, lambda { |search_string| 
    where(
      'name LIKE :q OR memo LIKE :q OR note LIKE :q', 
      {:q => "%#{search_string}%"}
    )
  }
  
  validates_presence_of :date, :name, :amount_in_pence, :fit_id, :type
  validates_uniqueness_of :fit_id
  
  def amount
    amount_in_pence/100.0
  end
  
  def description
    description = [name, memo].compact.join(' / ')
    "#{description} (#{type})"
  end
  
end