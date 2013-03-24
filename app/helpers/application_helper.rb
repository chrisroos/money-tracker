module ApplicationHelper

  def link_to_previous_period(period)
    previous_period = Date.from_period(period) - 1.month
    link_to transactions_path(:period => previous_period.to_s(:period)), :class => 'previous_period btn btn-info' do
      ['<i class="icon-chevron-left"></i>', previous_period.to_s(:month_and_year)].join(' ').html_safe
    end
  end

  def link_to_next_period(period)
    next_period = Date.from_period(period) + 1.month
    link_to transactions_path(:period => next_period.to_s(:period)), :class => 'next_period btn btn-info pull-right' do
      [next_period.to_s(:month_and_year), '<i class="icon-chevron-right"></i>'].join(' ').html_safe
    end
  end

end
