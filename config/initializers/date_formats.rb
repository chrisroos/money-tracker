# encoding: utf-8

Date::DATE_FORMATS[:human_friendly] = lambda { |date| date.strftime("%a #{date.day.ordinalize} %b %Y") }
Date::DATE_FORMATS[:weekday_and_day] = lambda { |date| date.strftime("%a #{date.day.ordinalize}") }
Date::DATE_FORMATS[:period] = '%Y-%m'
Date::DATE_FORMATS[:month_and_year] = '%B %Y'