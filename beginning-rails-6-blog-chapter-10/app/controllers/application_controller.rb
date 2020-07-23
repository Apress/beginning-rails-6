class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate
    logged_in? || access_denied
  end

  def logged_in?
    current_user.present?
  end

  def access_denied
    redirect_to(login_path, notice: "Please log in to continue") and return false
  end
end
