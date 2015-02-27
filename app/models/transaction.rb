class Transaction < ActiveRecord::Base
  self.inheritance_column = :_disabled_sti

  default_scope { order('COALESCE(date, original_date) DESC') }

  scope :search, ->(search_string) {
    if (m = /category:(.*)/.match(search_string))
      where(category: m[1])
    elsif (m = /description:(.*)/.match(search_string))
      where(description: m[1])
    else
      where(
        'name ILIKE :q OR memo ILIKE :q OR note ILIKE :q OR type ILIKE :q OR description ILIKE :q',
        q: "%#{search_string}%"
      )
    end
  }

  scope :period, ->(period) {
    date = Date.from_period(period)
    where(
      'COALESCE(date, original_date) >= ? AND COALESCE(date, original_date) <= ?',
      date.beginning_of_month, date.end_of_month
    )
  }

  def self.category_search(query)
    unscoped.select('DISTINCT(category)').where('category ILIKE :q', q: "%#{query}%").order('category ASC')
  end

  def self.description_search(query)
    unscoped.select('DISTINCT(description)').where('description ILIKE :q', q: "%#{query}%").order('description ASC')
  end

  def self.location_search(description, query)
    unscoped.select('DISTINCT(location)').where('UPPER(description) = UPPER(:description) AND location ILIKE :q', description: description, q: "%#{query}%").order('location ASC')
  end

  belongs_to :account

  validates :account_id, :original_date, :name, :amount_in_pence, :fit_id, :type, :original_description, presence: true
  validates :fit_id, uniqueness: true

  before_validation :set_original_description, on: :create

  def amount
    amount_in_pence / 100.0
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

    def set_original_description
      description = [name, memo].compact.join(' / ')
      self.original_description = "#{description} (#{type})"
    end
end
