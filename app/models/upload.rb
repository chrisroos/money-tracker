class Upload < ActiveRecord::Base
  validates :ofx_file, presence: true
end
