class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
  end

  def delete
  end
end
