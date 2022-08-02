class EndUser::PostsController < ApplicationController
  def index
    @post = Post.new
    posts = Post.includes(:user)
    users = []
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @post_comment = PostComment.new
    @post_tag = PostingTag.new
    @post_tags = PostingTag.all
  end

  def create
    @post = current_end_user.posts.new(post_params)
    case params[:post][:status]
    when "0"
      @post.status = "published"
    when "1"
      @post.status = "draft"
    end
    if @post.save
      tags = params[:post][:name].split(",")
      tags.each do |tag|
        tag = PostingTag.find_or_create_by(name: tag)
        @post.tags.delete(tag)
        @post.tags << tag
      end
    end
    posts = Post.includes(:user)
    users = []
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
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

  def index_all
    @post = Post.new
    @posts = Post.where(status: "published").with_attached_images.includes(:user).where(user: {status: "published"}).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @post_comment = PostComment.new
  end

  def draft
    @post = Post.new
    @posts = current_end_user.posts.where(status: "draft").includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, posting_tags: [:name], images: [])
  end
end
