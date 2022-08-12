class EndUser::UsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user, only: [:edit, :update, :open_user, :close_user]

  def show
    @user = EndUser.find(params[:id])
    @posts = Post.where(status: "published",end_user_id: @user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @post_comment = PostComment.new
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

  def open_user
    @user = EndUser.find(params[:id])
    @user.published! unless @user.published?
    redirect_to request.referer
  end

  def close_user
    @user = EndUser.find(params[:id])
    @user.privately! unless @user.privately?
    redirect_to request.referer
  end

  def dummy
    redirect_to new_end_user_registration_path
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :introduction, :email, :icon, :password, :password_confirmation, :reset_password_token)
  end

  def ensure_correct_user
    unless current_end_user.id == params[:id].to_i
      redirect_to posts_path, notice: "アカウントが違います"
    end
  end
end
