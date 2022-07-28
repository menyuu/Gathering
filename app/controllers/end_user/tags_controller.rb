class EndUser::TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    get_value = current_end_user
    tags = params[:tag][:name].split(",")
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      get_value.tags.delete(tag)
      get_value.tags << tag
    end
    redirect_to request.referer
  end

  def update
    tag = Tag.find_by(name: params[:name])
    current_end_user.tags.delete(tag)
    current_end_user.tags << tag
    redirect_to request.referer
  end

  def destroy
      tag = Tag.find_by(name: params[:name])
      if current_end_user.tags.size > 1
        current_end_user.tags.delete(tag)
        redirect_to request.referer
      else
        redirect_to request.referer
      end
  end
end
