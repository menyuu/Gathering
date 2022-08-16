class EndUser::PostingTagsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]
  before_action :ensure_correct_user



  def show
    @post = Post.find(params[:post_id])
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      # 所持しているタグの数が1つ以上あれば最後に半角カンマ(,)を表示する
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def create
    @post = Post.find(params[:post_id])
    tags = params[:posting_tag][:name].split(",")
    if tags.size < 9  && params[:posting_tag][:name].length < 51
      @post.tags.destroy_all
      tags.each do |tag|
        tag = PostingTag.find_or_create_by(name: tag)
        @post.tags << tag
      end
    else
      redirect_to request.referer, alert: "追加できるタグは50文字以内、もしくは8個までです。ご注意ください。"
    end
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def update
    @post = Post.find(params[:post_id])
    unless @post.tags.size == 8
      tag = PostingTag.find_by(name: params[:name])
      @post.tags.delete(tag)
      @post.tags << tag
    else
      redirect_to request.referer, alert: "タグの追加に失敗しました。追加できるタグは8個までです。"
    end
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    tags = @post.tags.all
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  private

  def ensure_correct_user
    @post = Post.find(params[:post_id])
    unless current_end_user == @post.user
      redirect_to user_path(current_end_user), alert: "アカウントが違うため編集できません。"
    end
  end
end
