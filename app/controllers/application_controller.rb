class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :friend_requests

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

  def friend_requests
    if current_user
      @friend_requests = current_user.get_friend_requests
    else
      @friend_requests = []
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
