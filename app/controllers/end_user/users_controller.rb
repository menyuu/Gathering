class EndUser::UsersController < ApplicationController
  def index
    @users = EndUser.all
  end

  def show
    @user = EndUser.find(params[:id])
  end

  def new
  end

  def edit
    @user = EndUser.find(params[:id])
  end

  def update
    @user = EndUser.find(params[:id])
    if @user.update(user_params)
      if params[:end_user][:password] && params[:end_user][:password_confirmation]
        sign_in(@user, bypass: true)
      end
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :introduction, :email, :image, :password, :password_confirmation, :reset_password_token)
  end
end
