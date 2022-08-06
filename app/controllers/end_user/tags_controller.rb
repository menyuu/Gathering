class EndUser::TagsController < ApplicationController
  def index
    @tags = Tag.display_show_type("user")
    @tag = Tag.new
  end

  def create
    Tag.create_tag(params[:tag][:name], current_end_user)
    @tags = Tag.display_show_type(params[:tag][:model])
    @tag = Tag.new
  end

  def update
    Tag.update_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
    @tag = Tag.new
  end

  def destroy
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
    @tag = Tag.new
  end
end
