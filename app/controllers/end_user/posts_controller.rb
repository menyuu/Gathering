class EndUser::PostsController < ApplicationController
  def index
    @posts = Post.where(status: "published").with_attached_images.includes(:user).where(user: {status: "published"}).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @post_comment = PostComment.new
    @post_tag = PostingTag.new
    @post_tags = PostingTag.all
  end

  def new
    @post = Post.new
  end

  def create
    post = current_end_user.posts.new(post_params)
    case params[:post][:status]
    when "0"
      post.status = "published"
    when "1"
      post.status = "draft"
    end
    if post.save
      tags = params[:post][:name].split(",")
      tags.each do |tag|
        tag = PostingTag.find_or_create_by(name: tag)
        post.tags.delete(tag)
        post.tags << tag
      end
      redirect_to post_path(post)
    else
      render :new
    end
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
    posts = Post.where(status: "published")
    users =[]
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users).with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def draft
    @posts = current_end_user.posts.where(status: 1)
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, posting_tags: [:name], images: [])
  end
end
