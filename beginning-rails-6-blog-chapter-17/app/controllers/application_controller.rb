class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  around_action :set_locale

  def set_locale(&action)
    session[:locale] = params[:locale] if params[:locale]
    I18n.with_locale(session[:locale] || I18n.default_locale, &action)
  end

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
    redirect_to(login_path, notice: t('application.access_denied')) and return false
  end
end
