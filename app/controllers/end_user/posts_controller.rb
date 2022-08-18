class EndUser::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :destroy]
  before_action :tag_items, only: [:index, :show, :index_all, :draft, :create]
  before_action :forbid_guestuser, only: [:create, :update, :destroy]

  def index
    @post = Post.new
    @post_comment = PostComment.new
    posts = Post.includes(:user)
    # フォロー中のユーザーとログイン中のユーザーを配列にする
    users = []
    users.push(current_end_user.followings, current_end_user)
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def index_all
    @post = Post.new
    @post_comment = PostComment.new
    # パブリックユーザーとフォロー中のユーザーとログイン中のユーザーを配列にする
    users = []
    other_published_users = EndUser.where(status: "published").reject { |user| user == current_end_user }
    users.push(other_published_users, current_end_user.followings, current_end_user)
    # 一次元配列に整理する
    users.flatten!
    # idが重複しているユーザーを取り除く
    unique_users = users.uniq { |user| user.id }
    @posts = Post.where(end_user_id: unique_users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @post_comment = PostComment.new
    @post_tag = PostingTag.new
    @comments = @post.post_comments.includes(user: [icon_attachment: [:blob]]).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    # タグの編集をするときに表示する
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      # 所持しているタグの数が1つ以上あれば最後に半角カンマ(,)を表示する
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def draft
    @posts = current_end_user.posts.where(status: "draft").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @tag_names = []
    @posts.each do |post|
      tags = post.tags
      if tags.count > 0
        @tag_names = tags.pluck(:name).join(",") + ","
      else
        @tag_names = tags.pluck(:name).join(",")
      end
    end
  end

  # 非同期を一旦休止
  def create
    @post = current_end_user.posts.new(post_params)
    @post_comment = PostComment.new
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
    tags = params[:post][:name].split(",")
    if tags.size < 9 && params[:post][:name].length < 51
      if @post.save
        # 持っているタグを全て削除して、追加する
        @post.tags.destroy_all
        tags.each do |tag|
            # タグが既に存在するかを探して存在しなければ作成する
          tag = PostingTag.find_or_create_by(name: tag)
          @post.tags << tag
        end
        redirect_to posts_path, notice: "正常に投稿されました。"
      else
        @tag_names = tags
        render :index
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:name].split(",")
    if tags.size < 9 && params[:post][:name].length < 51
      if @post.update(post_params)
        @post.tags.destroy_all
        tags.each do |tag|
          tag = PostingTag.find_or_create_by(name: tag)
          @post.tags << tag
        end
      end
      redirect_to request.referer, notice: "投稿の編集が完了しました。"
    else
      redirect_to request.referer, alert: "タグの追加に失敗しました。追加できるタグは50文字以内、もしくは8個までです。"
    end
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    @tag_names = []
    if @post.tags.count > 0
      @tag_names = @post.tags.pluck(:name).join(",") + ","
    else
      @tag_names = @post.tags.pluck(:name).join(",")
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, alert: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, images: [])
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    unless current_end_user == post.user
      flash[:alert] = "アカウントが違います。"
      redirect_to posts_path
    end
  end

  def tag_items
    @post_tags = Kaminari.paginate_array(PostingTag.display_show_type("post", 15)).page(params[:page]).per(5)
  end
end
