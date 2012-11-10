class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authorize
  helper_method :current_user
  
private 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to :back, alert: "Please login or sign up!" if !current_user
  end
end
