source 'https://rubygems.org'

ruby "2.0.0"

# Avoid "WARNING: Nokogiri was built against LibXML version 2.7.8, but has dynamically loaded 2.7.3"
gem 'nokogiri', '>= 1.4.4'

gem 'rails', '4.0.1'
gem 'pg'
gem 'haml'
gem 'thin'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use jquery-ui for autocomplete in text fields
gem 'jquery-ui-rails'

# Avoid iconv deprecation warning
gem 'ofx', git: 'git://github.com/chrisroos/ofx.git', branch: 'add-support-for-version-202-ofx-files'

# Send exception notifications by email
gem 'exception_notification'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'travis-lint'
  gem 'foreman'
  gem 'rubocop', require: false
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
