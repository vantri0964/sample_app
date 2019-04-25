class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      check_sucess user
    else
      flash.now[:danger] = t "controllers.session.email_pass_bug"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def check_sucess user
    log_in user
    params[:session][:remember_me] == t("controllers.session.remember_1") ? remember(user) : forget(user)
    redirect_to user
  end
end
