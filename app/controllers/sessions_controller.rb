class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by('email= ? OR user_name= ?', params[:email], params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user_path(@user), status: :see_other
    else
      flash[:alert] = 'Authentication failed!'
      redirect_to action: :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, notice: 'logged out', status: :see_other
  end
end
