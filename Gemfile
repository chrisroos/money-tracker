source 'http://rubygems.org'

# Avoid "WARNING: Nokogiri was built against LibXML version 2.7.8, but has dynamically loaded 2.7.3"
gem 'nokogiri', '>= 1.4.4'

gem 'rails', '3.2.2'
gem 'pg'
gem 'haml'

# Avoid iconv deprecation warning
gem 'ofx', :git => 'git://github.com/floehopper/ofx.git'

gem 'exception_notification', :require => 'exception_notifier'

group :development do
  gem 'heroku'
  gem 'travis-lint'
end

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end
