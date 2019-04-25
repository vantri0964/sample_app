module SessionsHelper
  def log_in user
    session[:id_user] = user.id
  end

  def current_user
    @curent_user = if session[:id_user]
                     @current_user ||= User.find_by(id: session[:id_user])
                   elsif cookies.signed[:user_id]
                     user = User.find(cookies.signed[:user_id])
                     user if user && authenticated?(cookies[:remember_token])
                   end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget current_user
    session.delete :id_user
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def current_user? user
    user == current_user
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
