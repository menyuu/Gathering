class EndUser::PostingTagsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]
  before_action :ensure_correct_user

  def show
    @post = Post.find(params[:post_id])
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
    @tag_names = @post.tag_names
  end

  def create
    @post = Post.find(params[:post_id])
    tags = params[:posting_tag][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 }
      PostingTag.create_tag(tags, @post)
    else
      render "layouts/error"
    end
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    @tag_names =  @post.tag_names
  end

  def update
    @post = Post.find(params[:post_id])
    if @post.tags.size < 8
      tag = PostingTag.find_by(name: params[:name])
      @post.tags.delete(tag)
      @post.tags << tag
    else
      render "layouts/error"
    end
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    @tag_names =  @post.tag_names
  end

  def destroy
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post_tag = PostingTag.new
    @post_tags = PostingTag.display_show_type("post")
    @tag_names =  @post.tag_names
  end

  private

  def ensure_correct_user
    @post = Post.find(params[:post_id])
    unless current_end_user == @post.user
      redirect_to user_path(current_end_user), alert: "アカウントが違うため編集できません。"
    end
  end
end
