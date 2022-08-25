class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = EndUser.page(params[:page]).per(1).order(created_at: :DESC)
  end

  def show
    @user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id: @user).with_attached_images.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  # 現在はupdateとdestroyに分類してステータスの変更
  def update
    @user = EndUser.find(params[:id])
    @user.update(status: "published")
    redirect_to request.referer, notice: "該当のユーザーのアカウントを復旧しました。"
  end

  def destroy
    @user = EndUser.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, alert: "該当のユーザーのアカウントを削除しました。"
  end

  def freeze
    @user = EndUser.find(params[:id])
    @user.update(status: "freeze")
    redirect_to request.referer, alert: "該当のユーザーのアカウント停止にしました。"
  end
end
