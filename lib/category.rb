# encoding: utf-8

class Category
  def self.search(query)
    Transaction.category_search(query).map(&:category)
  end
end