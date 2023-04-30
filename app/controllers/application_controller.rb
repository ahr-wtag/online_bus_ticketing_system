class ApplicationController < ActionController::Base
  helper_method :current_user

  def require_user_logged_in!
    # allows only logged in user
    redirect_to sign_in_path, alert: 'You must be signed in' if current_user.nil?
  end

  def current_user
    return unless session[:user_id]

    @current_user = User.find(session[:user_id])
  end
end
