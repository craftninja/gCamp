class UsersController < ApplicationController
  before_action :verify_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :verify_auth_to_edit, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was successfully created'
      redirect_to users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User was successfully deleted'
    redirect_to users_path
  end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def verify_auth_to_edit
    if !current_user_or_admin(@user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
