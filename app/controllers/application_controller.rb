class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controllers.application.please_log_in"
    redirect_to login_path
  end
end
