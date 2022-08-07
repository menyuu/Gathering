class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.includes(user: [icon_attachment: [:blob]]).page(params[:page]).without_count.per(1)
  end

  def delete
  end
end
