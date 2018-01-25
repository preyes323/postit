class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    not_allowed unless logged_in?
  end

  def admin?
    logged_in? && current_user.role.to_s.to_sym == :admin
  end

  def require_admin
    not_allowed unless admin?
  end

  private

  def not_allowed
    flash[:error] = 'You are not allowed to do that.'
    redirect_to root_path
  end
end
