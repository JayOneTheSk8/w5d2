class ApplicationController < ActionController::Base

  helper_method :current_user

  def log_in!(user)
    session[:session_token] = user.session_token
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def log_out!
    current_user.reset_session_token!
    current_user.save
    session[:session_token] = nil
  end
end
