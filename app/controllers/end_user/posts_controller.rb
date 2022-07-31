class EndUser::PostsController < ApplicationController
  def index
    @posts = Post.where(status: 0).order(created_at: :DESC).page(params[:page]).without_count.per(1)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tag = PostingTag.new
    @post_tags = PostingTag.all
  end

  def new
    @post = Post.new
  end

  def create
    post = current_end_user.posts.new(post_params)
    post.save
    tags = params[:post][:name].split(",")
    tags.each do |tag|
      tag = PostingTag.find_or_create_by(name: tag)
      post.tags.delete(tag)
      post.tags << tag
    end
    redirect_to post_path(post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def timeline
    posts = Post.where(status: 0)
    users = current_end_user.followings << current_end_user
    @posts = posts.where(end_user_id: users).order(created_at: :DESC)
  end

  def draft
    @posts = current_end_user.posts.where(status: 1)
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, :tag_name, images: [])
  end
end
