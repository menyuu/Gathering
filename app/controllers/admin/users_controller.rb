class Admin::UsersController < ApplicationController
  def index
    @users = EndUser.page(params[:page]).per(1).order(created_at: :DESC)
  end

  def show
    @user = EndUser.find(params[:id])
    @posts = Post.where(status: "published",end_user_id: @user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @post_comment = PostComment.new
  end

  def update
    @user = EndUser.find(params[:id])
    @user.update(status: "published")
    redirect_to request.referer, notice: "該当のユーザーのアカウントを復旧しました。"
  end

  def destroy
    @user = EndUser.find(params[:id])
    @user.update(status: "freeze")
    redirect_to request.referer, alert: "該当のユーザーのアカウント停止をしました。"
  end
end
