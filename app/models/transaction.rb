# encoding: utf-8

class Transaction < ActiveRecord::Base

  self.inheritance_column = :_disabled_sti

  default_scope order('COALESCE(date, original_date) DESC')

  scope :search, ->(search_string) {
    if search_string =~ /category:(.*)/
      where(category: $1)
    elsif search_string =~ /description:(.*)/
      where(description: $1)
    else
      where(
        'name ILIKE :q OR memo ILIKE :q OR note ILIKE :q OR type ILIKE :q OR description ILIKE :q',
        {q: "%#{search_string}%"}
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
    unscoped.select('DISTINCT(category)').where('category ILIKE :q', {q: "%#{query}%"}).order('category ASC')
  end

  def self.description_search(query)
    unscoped.select('DISTINCT(description)').where('description ILIKE :q', {q: "%#{query}%"}).order('description ASC')
  end

  validates_presence_of :original_date, :name, :amount_in_pence, :fit_id, :type, :original_description
  validates_uniqueness_of :fit_id

  attr_protected :original_date, :name, :amount_in_pence, :type, :fit_id, :memo, :original_description

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