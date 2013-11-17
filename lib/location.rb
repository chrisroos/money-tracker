class Location
  def self.search(description, query)
    Transaction.location_search(description, query).map(&:location).reject(&:blank?)
  end
end
