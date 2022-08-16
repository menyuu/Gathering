class EndUser::PostingTagsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]
  before_action :ensure_correct_user


  def show
    @post = Post.find(params[:post_id])
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
  end

  def create
    @post = Post.find(params[:post_id])
    tags = params[:posting_tag][:name].split(",")
    tags.each do |tag|
      tag = PostingTag.find_or_create_by(name: tag)
      @post.tags.delete(tag)
      @post.tags << tag
    end
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
  end

  def update
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post.tags << tag
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post_tags = PostingTag.display_show_type("post")
    @post_tag = PostingTag.new
  end

  private

  def ensure_correct_user
    post = Post.find(params[:post_id])
    unless current_end_user == post.user
      redirect_to user_path(current_end_user), alert: "アカウントが違うため編集できません。"
    end
  end
end
