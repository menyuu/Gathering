class EndUser::TagsController < ApplicationController
  before_action :login_admin
  before_action :log_out_user
  before_action :authenticate_end_user!
  before_action :notification_index, only: [:index]

  def index
    @tag = Tag.new
    @tags = Tag.display_show_type("user")
    @tag_names = current_end_user.tag_names
  end

  def create
    @tag = Tag.new
    tags = params[:tag][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 } && tags.all? { |tag| tag != "" }
      Tag.create_tag(tags, current_end_user)
    else
      render "layouts/tag_error"
    end
    @tags = Tag.display_show_type(params[:tag][:model])
    @tag_names = current_end_user.tag_names
  end

  def update
    @tag = Tag.new
    if current_end_user.tags.size < 8
      Tag.update_tag(params[:name], current_end_user)
    else
      render "layouts/tag_error"
    end
    @tags = Tag.display_show_type(params[:model])
    @tag_names = current_end_user.tag_names
  end

  def destroy
    @tag = Tag.new
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
    @tag_names = current_end_user.tag_names
  end
end
