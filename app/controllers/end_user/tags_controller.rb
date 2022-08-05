class EndUser::TagsController < ApplicationController
  # before_action :add_object, only: [:update]

  def index
    @tags = Tag.where(status: "prepared").sort {|a,b| b.users.size <=> a.users.size}.first(30)
    @tag = Tag.new
  end

  def create
    if params[:tag][:model] == "user"
      create_tag_model = current_end_user
      @tags = Tag.where(status: "prepared").sort {|a,b| b.users.size <=> a.users.size}.first(30)
    elsif params[:tag][:model] == "group"
      create_tag_model = Group.find(params[:tag][:id])
    end
    tags = params[:tag][:name].split(",")
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      create_tag_model.tags.delete(tag)
      create_tag_model.tags << tag
    end
    @tag = Tag.new
  end

  def update
    if params[:model] == "user"
      add_tag_model = current_end_user
      @tags = Tag.where(status: "prepared").sort {|a,b| b.users.size <=> a.users.size}.first(30)
    elsif params[:model] == "group"
      add_tag_model = Group.find(params[:id])
    end
    tag = Tag.find_by(name: params[:name])
    add_tag_model.tags.delete(tag)
    add_tag_model.tags << tag
    @tag = Tag.new
  end

  def destroy
    if params[:model] == "user"
      remove_tag_model = current_end_user
      @tags = Tag.where(status: "prepared").sort {|a,b| b.users.size <=> a.users.size}.first(30)
    elsif params[:model] == "group"
      remove_tag_model = Group.find(params[:id])
    end
    tag = Tag.find_by(name: params[:name])
    remove_tag_model.tags.size > 1
    remove_tag_model.tags.delete(tag)
    @tag = Tag.new
  end
end
