source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'haml'
gem 'thin'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

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
  gem 'foreman'
  gem 'rubocop', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'mocha', require: false
end
