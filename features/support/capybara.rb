Capybara.save_and_open_page_path = Rails.root.join('tmp', 'capybara')

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
