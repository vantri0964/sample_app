class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(only update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email]
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "controllers.password_reset.email_sent"
      redirect_to root_path
    else
      flash[:danger] = t "controllers.password_reset.not_found"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "controllers.password_reset.pass_has_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "controllers.password_reset.not_found"
    render :new
  end

  def valid_user
    redirect_to root_path unless  @user&.activated? &&
                                  @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "controllers.password_reset.pass_has_expired"
    redirect_to new_password_reset_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
