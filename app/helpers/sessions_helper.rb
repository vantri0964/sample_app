module SessionsHelper
  def log_in user
    session[:id_user] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:id_user] if session[:id_user]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :id_user
    @current_user = nil
  end
end
