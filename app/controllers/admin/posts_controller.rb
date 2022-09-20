class Admin::PostsController < ApplicationController
  before_action :login_end_user
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @comments = @post.post_comments.page(params[:page]).per(1).order(created_at: :DESC)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "ユーザーの投稿が正常に削除されました。"
  end
end
