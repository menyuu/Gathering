class EndUser::TagsController < ApplicationController
  # before_action :add_object, only: [:update]

  def index
    @tags = Tag.display_show_tags("user")
    @tag = Tag.new
  end

  def create
    if params[:tag][:model] == "user"
      create_tag_model = current_end_user
    elsif params[:tag][:model] == "group"
      create_tag_model = Group.find(params[:tag][:id])
    end
    tags = params[:tag][:name].split(",")
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      create_tag_model.tags.delete(tag)
      create_tag_model.tags << tag
    end
    @tags = Tag.display_show_tags(params[:tag][:model])
    @tag = Tag.new
  end

  def update
    if params[:model] == "user"
      add_tag_model = current_end_user
    elsif params[:model] == "group"
      add_tag_model = Group.find(params[:id])
    end
    tag = Tag.find_by(name: params[:name])
    add_tag_model.tags.delete(tag)
    add_tag_model.tags << tag
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end

  def destroy
    if params[:model] == "user"
      remove_tag_model = current_end_user
    elsif params[:model] == "group"
      remove_tag_model = Group.find(params[:id])
    end
    tag = Tag.find_by(name: params[:name])
    puts "-------------------"
    puts current_end_user.tags.size
    if remove_tag_model.tags.size > 1
      remove_tag_model.tags.delete(tag)
    end
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end
end
