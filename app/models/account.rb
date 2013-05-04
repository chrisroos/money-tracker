class Account < ActiveRecord::Base
  has_many :transactions

  validates :account_id, presence: true, uniqueness: true

  def name
    self[:name] || self[:account_id]
  end
end