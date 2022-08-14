class EndUser::UsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user, only: [:edit, :update, :open_user, :close_user]
  before_action :user_commons, only: [:show, :update]
  before_action :forbid_guestuser, only: [:update, :open_user, :close_user]

  def show
  end

  def update
    if @user.update(user_params)
      if params[:end_user][:password] && params[:end_user][:password_confirmation]
        sign_in(@user, bypass: true)
      end
      redirect_to user_path(@user)
    else
      render :show
    end
  end

  def open_user
    @user = current_end_user.update(status: "published")
  end

  def close_user
    @user = current_end_user.update(status: "privately")
  end

  def dummy
    redirect_to new_end_user_registration_path
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :introduction, :email, :icon, :password, :password_confirmation, :reset_password_token)
  end

  def user_commons
    @user = EndUser.find(params[:id])
    @post_comment = PostComment.new
    @posts = Post.where(status: "published", end_user_id: @user).with_attached_images.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def ensure_correct_user
    unless current_end_user.id == params[:id].to_i
      redirect_to posts_path, notice: "アカウントが違います"
    end
  end
end
