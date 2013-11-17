class Date
  def self.from_period(period)
    Date.parse("#{period}-01")
  end
end