# encoding: utf-8

class ApplicationController < ActionController::Base

  before_filter :authenticate

  protect_from_forgery

  private

  def current_period_transactions_path
    transactions_path(period: Date.today.to_s(:period))
  end

  def authenticate
    return true unless Rails.env.production?

    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USERNAME && password == PASSWORD
    end
  end

end
