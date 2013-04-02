source 'https://rubygems.org'

ruby "1.9.3"

# Avoid "WARNING: Nokogiri was built against LibXML version 2.7.8, but has dynamically loaded 2.7.3"
gem 'nokogiri', '>= 1.4.4'

gem 'rails', '3.2.13'
gem 'strong_parameters'
gem 'pg'
gem 'haml'
gem 'thin'

# Avoid iconv deprecation warning
gem 'ofx', :git => 'git://github.com/floehopper/ofx.git'

gem 'exception_notification', :require => 'exception_notifier'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem "twitter-bootstrap-rails"

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

group :development do
  gem 'travis-lint'
  gem 'taps'
  gem 'sqlite3'
  gem 'foreman'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'mocha', require: false
end
