class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to articles_path, notice: t('users.create_success')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to articles_path, notice: t('users.update_success')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
