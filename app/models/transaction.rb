class Transaction < ActiveRecord::Base
  
  set_inheritance_column :_disabled_sti
  
  default_scope order('COALESCE(date, original_date) DESC')
  
  scope :search, lambda { |search_string| 
    where(
      'name ILIKE :q OR memo ILIKE :q OR note ILIKE :q OR type ILIKE :q OR description ILIKE :q', 
      {:q => "%#{search_string}%"}
    )
  }
  
  validates_presence_of :original_date, :name, :amount_in_pence, :fit_id, :type
  validates_uniqueness_of :fit_id
  
  attr_protected :original_date, :name, :amount_in_pence, :type, :fit_id, :memo
  
  def amount
    amount_in_pence/100.0
  end
  
  def description
    read_attribute(:description) || original_description
  end
  
  def date
    read_attribute(:date) || original_date
  end
  
  private
  
    def original_description
      description = [name, memo].compact.join(' / ')
      "#{description} (#{type})"
    end
  
end