# encoding: utf-8

class Description
  def self.search(query)
    Transaction.description_search(query).map(&:description)
  end
end