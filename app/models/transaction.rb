class Transaction < ActiveRecord::Base
  
  set_inheritance_column :_disabled_sti
  
  default_scope order('COALESCE(date, original_date) DESC')
  
  scope :search, lambda { |search_string| 
    if search_string =~ /category:(.*)/
      where(:category => $1)
    else
      where(
        'name ILIKE :q OR memo ILIKE :q OR note ILIKE :q OR type ILIKE :q OR description ILIKE :q', 
        {:q => "%#{search_string}%"}
      )
    end
  }
  
  scope :period, lambda { |period|
    date = Date.from_period(period)
    where(
      "COALESCE(date, original_date) >= ? AND COALESCE(date, original_date) <= ?",
      date.beginning_of_month, date.end_of_month
    )
  }
  
  def self.find_by_description(description)
    if transaction = where(:description => description).first
      return transaction
    else
      if description =~ /(.*) \/ (.*) \((.*)\)/
        name, memo, type = $1, $2, $3
        if transaction = where("UPPER(name) = UPPER(?) AND UPPER(memo) = UPPER(?) AND UPPER(type) = UPPER(?)", name, memo, type).first
          return transaction
        end
      elsif description =~ /(.*) \((.*)\)/
        name, type = $1, $2
        if transaction = where("UPPER(name) = UPPER(?) AND UPPER(type) = UPPER(?)", name, type).first
          return transaction
        end
      end
    end
  end
  
  validates_presence_of :original_date, :name, :amount_in_pence, :fit_id, :type
  validates_uniqueness_of :fit_id
  
  attr_protected :original_date, :name, :amount_in_pence, :type, :fit_id, :memo
  
  def amount
    amount_in_pence/100.0
  end
  
  def credit?
    amount > 0
  end
  
  def debit?
    amount < 0
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