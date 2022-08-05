class EndUser::TagsController < ApplicationController
  # before_action :add_object, only: [:update]

  def index
    @tags = Tag.display_show_tags("user")
    @tag = Tag.new
  end

  def create
    Tag.create_tag(params[:tag][:name], current_end_user)
    @tags = Tag.display_show_tags(params[:tag][:model])
    @tag = Tag.new
  end

  def update
    Tag.update_tag(params[:name], current_end_user)
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end

  def destroy
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end
end
