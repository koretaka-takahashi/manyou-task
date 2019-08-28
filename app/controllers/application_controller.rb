class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def login_check
    render 'sessions/new' if logged_in? == false
  end  
end
