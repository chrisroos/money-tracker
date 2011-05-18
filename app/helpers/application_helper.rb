module ApplicationHelper
  
  def link_to_previous_period(period)
    previous_period = Date.parse("#{period}-01") - 1.month
    link_to previous_period.strftime("%B %Y"), transactions_path(:period => previous_period.strftime("%Y-%m"))
  end
  
  def link_to_next_period(period)
    next_period = Date.parse("#{period}-01") + 1.month
    link_to next_period.strftime("%B %Y"), transactions_path(:period => next_period.strftime("%Y-%m"))
  end
  
end
