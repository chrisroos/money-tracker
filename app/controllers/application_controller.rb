class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  private

  def current_period_transactions_path
    transactions_path(period: Time.zone.today.to_s(:period))
  end

  def authenticate
    return true unless Rails.env.production?

    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USERNAME && password == PASSWORD
    end
  end

  def demo_mode?
    ENV['DEMO_MODE']
  end
end
