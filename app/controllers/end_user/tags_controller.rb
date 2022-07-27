class EndUser::TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tag = Tag.new
    @user_tags = current_end_user.tags.pluck(:name).join(",")
  end

  def show
    @tags = Tag.all
    @tag = Tag.new
    @user_tags = current_end_user.tags.pluck(:name).join(",")
  end

  def new
  end

  def create
    attach_object = current_end_user
    tags = params[:tag][:name].split(',')
    tags.each do |tag|
      attach_object.tags.delete(Tag.find_by(name: tag))
      tag = Tag.find_or_create_by(name: tag)
      attach_object.tags << tag
    end
    redirect_to request.referer
  end

  def edit
  end

  def update
    puts "--------------------"
    puts params[:name]

    tag = Tag.find_by(name: params[:name])
    current_end_user.tags << tag
    redirect_to request.referer

    # has_tags = Tag.where(id: params[:name])
    # tags = []
    # has_tags.each do |tag|
    #   tags << tag.name
    # end
    # current_end_user.tag_save(tags)
    # redirect_to request.referer
  end
end
