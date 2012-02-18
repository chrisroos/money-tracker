source 'http://rubygems.org'

# Avoid "WARNING: Nokogiri was built against LibXML version 2.7.8, but has dynamically loaded 2.7.3"
gem 'nokogiri', '>= 1.4.4'

gem 'rails', '~> 3.1.0'
gem 'pg'
gem 'haml'
gem 'rack-ssl', :require => 'rack/ssl'

# Avoid iconv deprecation warning
gem 'ofx', :git => 'git://github.com/floehopper/ofx.git'

gem 'exception_notification', :require => 'exception_notifier'

group :development do
  gem 'heroku'
end

group :test do
  gem 'cucumber-rails', '~> 0.5.1'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end
