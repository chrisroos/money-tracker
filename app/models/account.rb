class Account < ActiveRecord::Base
  has_many :transactions

  validates :account_id, presence: true, uniqueness: true
end