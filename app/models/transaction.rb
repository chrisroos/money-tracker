class Transaction < ActiveRecord::Base
  validates_presence_of :datetime, :description
end