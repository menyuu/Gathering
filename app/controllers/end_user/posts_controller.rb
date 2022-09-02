class EndUser::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :destroy]
  before_action :tag_items, only: [:index, :show, :index_all, :draft, :create]
  before_action :post_comment_new, only: [:index, :index_all, :show, :create]
  before_action :post_index, only: [:index, :create]
  before_action :disallow_draft_other_user, only: [:show]

  def index
    @post = Post.new
  end

  def index_all
    # パブリックユーザーとフォロー中のユーザーとログイン中のユーザーを配列にする
    users = []
    # パブリックユーザーの配列からログイン中のユーザーを省いた配列にする
    other_published_users = EndUser.where(status: "published").reject { |user| user == current_end_user }
    # パブリックユーザーと凍結されていないフォロー中のユーザーと現在ログイン中のユーザーを配列に代入する
    users.push(other_published_users, current_end_user.followings.where.not(status: "freeze"), current_end_user)
    users.flatten!
    # idが重複しているユーザーを取り除く
    unique_users = users.uniq { |user| user.id }
    @posts = Post.where(end_user_id: unique_users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(updated_at: :DESC)
  end

  def show
    @post = Post.with_attached_images.find(params[:id])
    @comments = @post.post_comments.includes(user: [icon_attachment: [:blob]]).page(params[:page]).without_count.per(5)
    @comments.each do |comment|
      puts "---------------------"
      puts comment.user.published?
    end

    # タグの編集をするときに表示する
    @tag_names = @post.tag_names
  end

  def draft
    @posts = current_end_user.posts.where(status: "draft").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(updated_at: :DESC)
  end

  def create
    @post = current_end_user.posts.new(post_params)
    # 送られてきた値によってステータス値を代入する
    case params[:post][:status]
    when "0"
      @post.status = "published"
    when "1"
      @post.status = "draft"
    end
    tags = params[:post][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 } && tags.all? { |tag| tag != "" }
      if @post.save
        PostingTag.create_tag(tags, @post)
        @post.images.each do |image|
          vision_tags = Vision.get_image_data(image)
          vision_tags.each do |tag|
            @post.tags.find_or_create_by(name: tag)
            # post_tag = PostingTag.find_or_create_by(name: tag)
            # @post.tags << post_tag
          end
        end
        redirect_to request.referer, notice: "正常に投稿されました。"
      else
        # 投稿本文のエラー
        @tag_names = tags.join(",") + ","
        render :error
      end
    else
      # タグのエラー
      @tag_names = tags.join(",") + ","
      render "layouts/tag_error"
    end
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 } && tags.all? { |tag| tag != "" }
      if @post.update(post_params)
        PostingTag.create_tag(tags, @post)
        redirect_to request.referer, notice: "投稿の編集が完了しました。"
      else
        @tag_names = @post.tag_names
        render :error
      end
    else
      @tag_names = @post.tag_names
      render "layouts/tag_error"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, alert: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:text, :status, :name, images: [])
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    unless current_end_user == post.user
      redirect_to posts_path, alert: "アカウントが違います。"
    end
  end

  def disallow_draft_other_user
    post = Post.find(params[:id])
    if post.draft? && (post.user != current_end_user)
      redirect_to posts_path, alert: "アカウントが違います。"
    end
  end

  # タグのサイドバー表示用
  def tag_items
    @post_tags = Kaminari.paginate_array(PostingTag.display_show_type("post", 15))
  end

  # 新規コメントの作成
  def post_comment_new
    @post_comment = PostComment.new
  end

  def post_index
    posts = Post.includes(:user)
    # フォロー中のユーザーとログイン中のユーザーを配列にする
    users = []
    users.push(current_end_user.followings.where.not(status: "freeze"), current_end_user)
    # 一次元配列に整理する
    users.flatten!
    @posts = posts.where(end_user_id: users, status: "published").with_attached_images.includes(:user).page(params[:page]).without_count.per(1).order(updated_at: :DESC)
  end
end
