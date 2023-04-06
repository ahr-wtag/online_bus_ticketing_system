class UsersController < ApplicationController
  before_action :find_user_by_id, only: %i[edit update show]
  before_action :require_user_logged_in!, only: %i[show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sign_in_path, notice: 'Succesfully created account'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_name, :password, :password_digest, :phone)
  end

  def find_user_by_id
    @user = User.find(params[:id])
  end
end
