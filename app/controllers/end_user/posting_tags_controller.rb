class EndUser::PostingTagsController < ApplicationController
  before_action :login_admin
  before_action :authenticate_end_user!
  before_action :ensure_correct_user
  before_action :common_post_tag
  before_action :notification_index, only: [:show]

  def show
    @post_tags = PostingTag.display_show_type("post")
    @tag_names = @post.tag_names
  end

  def create
    tags = params[:posting_tag][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 } && tags.all? { |tag| tag != "" }
      PostingTag.create_tag(tags, @post)
    else
      render "layouts/tag_error"
    end
    @post_tags = PostingTag.display_show_type("post")
    @tag_names =  @post.tag_names
  end

  def update
    if @post.tags.size < 8
      PostingTag.update_tag(params[:name], @post)
    else
      render "layouts/tag_error"
    end
    @post_tags = PostingTag.display_show_type("post")
    @tag_names =  @post.tag_names
  end

  def destroy
    PostingTag.destroy_tag(params[:name], @post)
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

  def common_post_tag
    @post = Post.find(params[:post_id])
    @post_tag = PostingTag.new
  end
end
