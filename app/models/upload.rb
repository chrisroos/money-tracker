# encoding: utf-8

class Upload < ActiveRecord::Base
  validates_presence_of :ofx_file
end