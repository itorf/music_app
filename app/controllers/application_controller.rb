class ApplicationController < ActionController::Base
  helper_method :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    user = User.find_by_session_token(session[:session_token])
    user.nil? ? nil : user
  end
  
  def signed_in?
    !!current_user
  end
  
  def login_user!(user)
    token = User.generate_session_token
    session[:session_token] = token
    user.session_token = token
    user.save
  end
  
  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end
  
  def redirect_if_not_logged_in
    redirect_to new_session_url unless signed_in?
  end
end
