class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :load_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update])
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @user = User
            .user_activated
            .paginate page: params[:page], per_page: Settings.app.user.page
  end

  def show
    @microposts = @user
                  .microposts
                  .paginate page: params[:page],
                  per_page: Settings.app.user.page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controllers.user.user_mail", date: @user.created_at,
                     name: @user.name
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:info] = t "controllers.user.delete"
    else
      flash[:danger] = t "controllers.user.delete_bug"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controllers.user.id_not_find"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
