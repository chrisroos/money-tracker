class Transaction < ActiveRecord::Base
  belongs_to :account

  validates :account_id, :source_date, :source_name, :source_amount_in_pence, :source_fit_id, :source_type, :original_description, presence: true
  validates :source_fit_id, uniqueness: true

  before_validation :set_original_description, on: :create

  default_scope { order('COALESCE(date, source_date) DESC') }

  def self.search(search_string)
    if (m = /category:(.*)/.match(search_string))
      where(category: m[1])
    elsif (m = /description:(.*)/.match(search_string))
      where(description: m[1])
    else
      where(
        'source_name ILIKE :q OR source_memo ILIKE :q OR note ILIKE :q OR source_type ILIKE :q OR description ILIKE :q',
        q: "%#{search_string}%"
      )
    end
  end

  def self.period(period)
    date = Date.from_period(period)
    where(
      'COALESCE(date, source_date) >= ? AND COALESCE(date, source_date) <= ?',
      date.beginning_of_month, date.end_of_month
    )
  end

  def self.category_search(query)
    unscoped.select('DISTINCT(category)').where('category ILIKE :q', q: "%#{query}%").order('category ASC')
  end

  def self.description_search(query)
    unscoped.select('DISTINCT(description)').where('description ILIKE :q', q: "%#{query}%").order('description ASC')
  end

  def self.location_search(description, query)
    unscoped.select('DISTINCT(location)').where('UPPER(description) = UPPER(:description) AND location ILIKE :q', description: description, q: "%#{query}%").order('location ASC')
  end

  def amount
    source_amount_in_pence / 100.0
  end

  def credit?
    amount > 0
  end

  def debit?
    amount < 0
  end

  def description
    self[:description] || original_description
  end

  def date
    self[:date] || source_date
  end

  private

  def set_original_description
    description = [source_name, source_memo].compact.join(' / ')
    self.original_description = "#{description} (#{source_type})"
  end
end
