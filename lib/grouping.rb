class Grouping
  def self.search(query)
    Transaction.grouping_search(query).map(&:grouping)
  end
end
