class EndUser::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :update, :destroy]
  # before_action :tag_items, only: [:index, :index_all]
  # before_action :user_has_tags?

  def index
    @post = Post.new
    @post_comment = PostComment.new
    posts = Post.includes(:user)
    users = []
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)

  end

  def index_all
    @post = Post.new
    @post_comment = PostComment.new
    users = []
    other_published_users = EndUser.where(status: "published").reject { |user| user == current_end_user }
    users.push(other_published_users, current_end_user.followings, current_end_user)
    users.flatten!
    unique_users = users.uniq { |user| user.id }
    @posts = Post.where(end_user_id: unique_users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @post_comment = PostComment.new
    @post_tag = PostingTag.new
    @comments = @post.post_comments.includes(user: [icon_attachment: [:blob]]).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  # 非同期を一旦休止
  def create
    @post = current_end_user.posts.new(post_params)
    posts = Post.includes(:user)
    users = []
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
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
      redirect_to posts_path, notice: "正常に投稿されました。"
    else
      redirect_to posts_path, notice: "投稿に失敗しました。"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      tags = params[:post][:name].split(",")
      tags.each do |tag|
        tag = PostingTag.find_or_create_by(name: tag)
        @post.tags.delete(tag)
        @post.tags << tag
      end
    end
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


  def draft
    @posts = current_end_user.posts.where(status: "draft").includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @tag_names = []
    @posts.each do |post|
      tags = post.tags.all
      if tags.count > 0
        @tag_names = tags.pluck(:name).join(",") + ","
      else
        @tag_names = tags.pluck(:name).join(",")
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, images: [])
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    unless current_end_user == post.user
      flash[:notice] = "アカウントが違います。"
      redirect_to posts_path
    end
  end

  # def tag_items
  #   @post_tags = Kaminari.paginate_array(PostingTag.display_show_type("post", 15)).page(params[:page]).per(5)
  #   @tags = Kaminari.paginate_array(Tag.display_show_type("user", 15)).page(params[:page]).per(5)
  #   @genres = Kaminari.paginate_array(Genre.display_show_type("user", 15)).page(params[:page]).per(5)
  #   @games = Kaminari.paginate_array(Game.display_show_type("user", 15)).page(params[:page]).per(5)
  # end
end
