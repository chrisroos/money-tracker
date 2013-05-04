class Account < ActiveRecord::Base
  validates :account_id, presence: true, uniqueness: true
end