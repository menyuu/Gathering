class EndUser::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    post = current_end_user.posts.new(post_params)
    post.save
    redirect_to posts_path
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:text, images: [])
  end
end
