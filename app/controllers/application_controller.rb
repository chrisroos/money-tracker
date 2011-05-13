class ApplicationController < ActionController::Base
  
  before_filter :authenticate
  
  protect_from_forgery
  
  private
  
  def authenticate
    return true unless Rails.env.production?
    
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USERNAME && password == PASSWORD
    end
  end
  
end
