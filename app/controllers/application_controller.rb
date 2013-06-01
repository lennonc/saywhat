class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  protected
  def logged_in?
    current_user != nil
  end 

  def authorize
    unless logged_in?
      flash[:error] = "Unauthorized access"
      redirect_to log_in_path
      false
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
