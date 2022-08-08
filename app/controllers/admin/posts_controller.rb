class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.page(params[:page]).per(1)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "ユーザーの投稿が正常に削除されました。"
  end
end